//
//  Aqi_List+CoreDataProperties.swift
//  twaqi-master
//
//  Created by Soar on 2019/7/11.
//  Copyright © 2019 Soar. All rights reserved.
//
//

import Foundation
import CoreData


extension Aqi_List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Aqi_List> {
        return NSFetchRequest<Aqi_List>(entityName: "Aqi_List")
    }

    @NSManaged public var aqi: Int64
    @NSManaged public var co: Float
    @NSManaged public var co_8hr: Float
    @NSManaged public var county: String?
    @NSManaged public var id: Int64
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var no: Float
    @NSManaged public var no2: Float
    @NSManaged public var nox: Float
    @NSManaged public var o3: Float
    @NSManaged public var o3_8hr: Float
    @NSManaged public var pm10: Float
    @NSManaged public var pm10_avg: Float
    @NSManaged public var pm25: Float
    @NSManaged public var pm25_avg: Float
    @NSManaged public var pollutant: String?
    @NSManaged public var publishtime: String?
    @NSManaged public var sitename: String?
    @NSManaged public var so2: Float
    @NSManaged public var so2_avg: Float
    @NSManaged public var status: String?
    @NSManaged public var winddirec: Float
    @NSManaged public var windspeed: Float

}
