//
//  aqiData.swift
//  twaqi-master
//
//  Created by Soar on 2019/7/7.
//  Copyright © 2019 Soar. All rights reserved.
//

import Foundation
import UIKit
import CoreData


let AQI_URL = "http://opendata.epa.gov.tw/webapi/Data/REWIQA/?$orderby=Longitude,Latitude&$skip=0&format=json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

struct AQI: Codable{
    var SiteName:String?
    var County:String?
    var AQI:String?
    var Pollutant:String?
    var Status:String?
    var SO2:String?
    var CO:String?
    var CO_8hr:String?
    var O3:String?
    var O3_8hr:String?
    var PM10:String?
    var PM25:String?
    var NO2:String?
    var NOx:String?
    var NO:String?
    var WindSpeed:String?
    var WindDirec:String?
    var PublishTime:String?
    var PM25_AVG:String?
    var PM10_AVG:String?
    var SO2_AVG:String?
    var Longitude:String?
    var Latitude:String?
    
    enum CodingKeys: String, CodingKey {
        case SiteName = "SiteName"
        case County = "County"
        case AQI = "AQI"
        case Pollutant = "Pollutant"
        case Status = "Status"
        case SO2 = "SO2"
        case CO = "CO"
        case CO_8hr = "CO_8hr"
        case O3 = "O3"
        case O3_8hr = "O3_8hr"
        case PM10 = "PM10"
        case PM25 = "PM2.5"
        case NO2 = "NO2"
        case NOx = "NOx"
        case NO = "NO"
        case WindSpeed = "WindSpeed"
        case WindDirec = "WindDirec"
        case PublishTime = "PublishTime"
        case PM25_AVG = "PM2.5_AVG"
        case PM10_AVG = "PM10_AVG"
        case SO2_AVG = "SO2_AVG"
        case Longitude = "Longitude"
        case Latitude = "Latitude"
    }
}

/*
class CoreDataStack: NSObject {
    
    static let sharedInstance = CoreDataStack()
    private override init() {}
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Photo.self))
        //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        //let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        //frc.delegate = self
        return 
    }()
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "twaqi_master")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}



extension CoreDataStack {
    
    func applicationDocumentsDirectory() {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "yo.BlogReaderApp" in the application's documents directory.
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
}
*/
