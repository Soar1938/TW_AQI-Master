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
    private var persistenceController: PersistenceController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /*persistenceController = PersistenceController { [weak self] in
            self?.GetCompleteAQIData()
        }*/
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
        persistenceController?.save()
    }
    
    private func GetCompleteAQIData() {
        /*if let url = URL(string: AQI_URL!) {
            let task = URLSession.shared.dataTask(with: url)
            {(data, response, error) in
                let decoder = JSONDecoder()
                if let data = data , let result = try? decoder.decode([AQI].self , from: data){
                    DispatchQueue.main.async {
                        if result.count != 0 {
                            self.persistenceController?.Aqi().forEach { Aqi_Del in
                                print("Delete Aqi: \(Aqi_Del.sitename!) ： \(Aqi_Del.county!)")
                                self.persistenceController?.delete(Aqi_Del) { [weak self] in
                                    print("Number of authors after delete: \(String(describing: self?.persistenceController?.Aqi().count))")
                                }
                            }
                            for aqi in result {
                                print("SiteName: \(aqi.SiteName!)")
                                self.persistenceController?.createAqi(with: aqi)
                            }
                        }
                        print("Aqi Count: \(self.persistenceController?.Aqi().count as Int?)")
                    }
                }
            }
            task.resume()
        }*/
    }
}

