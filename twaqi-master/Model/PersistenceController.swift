//
//  PersistenceController.swift
//  twaqi-master
//
//  Created by Soar on 2019/7/14.
//  Copyright © 2019 Soar. All rights reserved.
//

import Foundation
import CoreData

// Source: http://martiancraft.com/blog/2015/03/core-data-stack/

final class PersistenceController: NSObject {
    typealias InitCallbackBlock = () -> ()
    
    // **This is the application’s Single Source Of Truth.**
    // This is the NSManagedObjectContext that the application will use for
    // all user interaction. If we need to display something to the user,
    // we use this context. If the user is going to edit something, we use
    // this context. No exceptions.
    internal var managedObjectContext: NSManagedObjectContext?
    
    // Private Queue Context. The private queue context has one job in life.
    // It writes to disk. Such a simple and yet vital job in the application.
    // We build this as a private queue because we specifically want it to be
    // asynchronous from the UI. We want to avoid locking the UI as much as
    // possible because of the persistence layer.
    private var privateContext: NSManagedObjectContext?
    private var initCallbackBlock: (InitCallbackBlock)?
    
    init(_ initCallbackBlock: @escaping InitCallbackBlock) {
        super.init()
        self.initializeCoreData()
        self.setInitCallback(initCallbackBlock)
    }
    
    private func initializeCoreData() {
        guard
            managedObjectContext == nil,
            let modelURL = Bundle.main.url(forResource: "twaqi_master", withExtension: "momd"),
            let mom = NSManagedObjectModel(contentsOf: modelURL)
            else { return }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        privateContext?.persistentStoreCoordinator = coordinator
        managedObjectContext?.parent = privateContext
        
        DispatchQueue.global(qos: .background).async {
            guard let psc = self.privateContext?.persistentStoreCoordinator else { return }
            
            var options = [String: Any]()
            options[NSMigratePersistentStoresAutomaticallyOption] = true
            options[NSInferMappingModelAutomaticallyOption] = true
            options[NSSQLitePragmasOption] = ["journal_mode": "DELETE"]
            
            let fileManager = FileManager.default
            guard let documentsURL = fileManager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last else { return }
            let storeURL = documentsURL.appendingPathComponent("twaqi_master.sqlite")
            
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
            } catch {
                fatalError("Error: Adding persistent store.")
            }
            
            guard let initCallbackBlock = self.initCallbackBlock else { return }
            
            // "This can probably be called asynchronously but I am a
            // ‘belt and suspenders’ type of guy when it comes to this stuff."
            DispatchQueue.main.sync {
                initCallbackBlock()
            }
        }
    }
    
    private func setInitCallback(_ initCallbackBlock: @escaping InitCallbackBlock) {
        self.initCallbackBlock = initCallbackBlock
    }
    
    // MARK: - Save
    
    func save(completion: (() -> ())? = nil) {
        guard let privateContext = privateContext else {
            return
        }
        guard let managedObjectContext = managedObjectContext else {
            return
        }
        guard privateContext.hasChanges || managedObjectContext.hasChanges else {
            return
        }
        
        // Since we cannot guarantee that caller is the main thread, we
        // use --performBlockAndWait: against the main context to insure
        // we are talking to it on its own terms.
        managedObjectContext.performAndWait {
            // Once the main context has saved then we move on to the private queue.
            // This queue can be asynchronous without any issues so we call --performBlock:
            // on it and then call save.
            managedObjectContext.processPendingChanges()
            do {
                try managedObjectContext.save()
                //print("Write finished (main moc)")
            } catch {
                fatalError("Error saving (main moc).")
            }
            
            privateContext.perform {
                do {
                    try privateContext.save()
                    privateContext.processPendingChanges()
                    //print("Write finished (private moc)")
                    completion?()
                } catch {
                    fatalError("Error saving (private moc).")
                }
            }
        }
    }
    
    // Domain specific functionality
    
    // MARK: - Create
    
    //@discardableResult
    func createAqi(with aqi:AQI) {
        guard let managedObjectContext = managedObjectContext else { return }
        managedObjectContext.performAndWait { [weak self] in
            let aqiDB = Aqi_List(context: managedObjectContext)
            aqiDB.sitename    = aqi.SiteName
            aqiDB.county      = aqi.County
            aqiDB.aqi         = (aqi.AQI! as NSString).intValue
            aqiDB.pollutant   = aqi.Pollutant
            aqiDB.status      = aqi.Status
            aqiDB.so2         = (aqi.SO2! as NSString).floatValue
            aqiDB.co          = (aqi.CO! as NSString).floatValue
            aqiDB.co_8hr      = (aqi.CO_8hr! as NSString).floatValue
            aqiDB.o3          = (aqi.O3! as NSString).floatValue
            aqiDB.o3_8hr      = (aqi.O3_8hr! as NSString).floatValue
            aqiDB.pm10        = (aqi.PM10! as NSString).floatValue
            aqiDB.pm25        = (aqi.PM25! as NSString).floatValue
            aqiDB.no2         = (aqi.NO2! as NSString).floatValue
            aqiDB.nox         = (aqi.NOx! as NSString).floatValue
            aqiDB.no          = (aqi.NO! as NSString).floatValue
            aqiDB.windspeed   = (aqi.WindSpeed! as NSString).floatValue
            aqiDB.winddirec   = (aqi.WindDirec! as NSString).floatValue
            aqiDB.publishtime = aqi.PublishTime
            aqiDB.pm25_avg    = (aqi.PM25_AVG! as NSString).floatValue
            aqiDB.pm10_avg    = (aqi.PM10_AVG! as NSString).floatValue
            aqiDB.so2_avg     = (aqi.SO2_AVG! as NSString).floatValue
            aqiDB.longitude   = (aqi.Longitude! as NSString).doubleValue
            aqiDB.latitude    = (aqi.Latitude! as NSString).doubleValue
            self?.save()
        }
    }
    
    // MARK: - Read
    
    func objects<T>(from entity: String, sortDescriptor: NSSortDescriptor, fetchLimit: Int? = nil) -> [T] {
        guard let managedObjectContext = managedObjectContext else { return [] }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)
        
        fetchRequest.entity = entityDescription
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let fetchLimit = fetchLimit { fetchRequest.fetchLimit = fetchLimit }
        
        do {
            guard let objects = try managedObjectContext.fetch(fetchRequest) as? [T] else { return [] }
            return objects
        } catch {
            print("Error fetching")
            return []
        }
    }
    
    func Aqi(_ limit: Int? = nil) -> [Aqi_List] {
        let sortDescriptor = NSSortDescriptor(key: "county", ascending: true)
        return objects(from: "Aqi_List", sortDescriptor: sortDescriptor, fetchLimit: limit)
    }
    
    // MARK: - Delete
    
    func delete<T: NSManagedObject>(_ obj: T, completion: (() -> ())? = nil) {
        guard let managedObjectContext = managedObjectContext else { return }
        managedObjectContext.delete(obj)
        save {
            completion?()
        }
    }
}
