//
//  AppDelegate.swift
//  twaqi-master
//
//  Created by Soar on 2019/7/7.
//  Copyright © 2019 Soar. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var aqiData :[AQI]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CoreDataStack.sharedInstance.applicationDocumentsDirectory()
        self.GetCompleteAQIData()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataStack.sharedInstance.saveContext()
    }
    
    private func GetCompleteAQIData() {
        if let url = URL(string: AQI_URL!) {
            // print("RESPONSE url: \(url)")
            let task = URLSession.shared.dataTask(with: url)
            {(data, response, error) in
                //print("RESPONSE FROM API: \(response)")
                let decoder = JSONDecoder()
                
                if let data = data , let result = try? decoder.decode([AQI].self, from: data){
                    print("RESPONSE FROM API: \(result)")
                    self.aqiData = result
                    DispatchQueue.main.async {
                        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
                        let aqi = NSEntityDescription.insertNewObject(forEntityName: "Aqi_List", into: context)as! Aqi_List
                        //var ArrayCut: Int? = self.aqiData?.description.count
                        if self.aqiData!.count != 0 {
                            self.clearData()
                            //新增資料
                            for i in (0...self.aqiData!.count-1) {
                                aqi.id = Int64(i)
                                aqi.sitename = self.aqiData![i].SiteName!
                                aqi.county = self.aqiData![i].County!
                                aqi.aqi = (self.aqiData![i].AQI! as NSString).longLongValue
                                aqi.pollutant = self.aqiData![i].Pollutant!
                                aqi.status = self.aqiData![i].Status!
                                aqi.so2 = (self.aqiData![i].SO2! as NSString).floatValue
                                aqi.co = (self.aqiData![i].CO! as NSString).floatValue
                                aqi.co_8hr = (self.aqiData![i].CO_8hr! as NSString).floatValue
                                aqi.o3 = (self.aqiData![i].O3! as NSString).floatValue
                                aqi.o3_8hr = (self.aqiData![i].O3_8hr! as NSString).floatValue
                                aqi.pm10 = (self.aqiData![i].PM10! as NSString).floatValue
                                aqi.pm25 = (self.aqiData![i].PM25! as NSString).floatValue
                                aqi.no2 = (self.aqiData![i].NO2! as NSString).floatValue
                                aqi.nox = (self.aqiData![i].NOx! as NSString).floatValue
                                aqi.no = (self.aqiData![i].NO! as NSString).floatValue
                                aqi.windspeed = (self.aqiData![i].WindSpeed! as NSString).floatValue
                                aqi.winddirec = (self.aqiData![i].WindDirec! as NSString).floatValue
                                aqi.publishtime = self.aqiData![i].PublishTime!
                                aqi.pm25_avg = (self.aqiData![i].PM25_AVG! as NSString).floatValue
                                aqi.pm10_avg = (self.aqiData![i].PM10_AVG! as NSString).floatValue
                                aqi.so2_avg = (self.aqiData![i].SO2_AVG! as NSString).floatValue
                                aqi.longitude = (self.aqiData![i].Longitude! as NSString).doubleValue
                                aqi.latitude = (self.aqiData![i].Latitude! as NSString).doubleValue
                                
                                do {
                                    try context.save()
                                    print("儲存成功\(i)")
                                }catch let error{
                                    print("context can't save!, Error:\(error)")
                                }
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func clearData() {
        do {
            
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Aqi_List.self))
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
}

