//
//  aqiData.swift
//  twaqi-master
//
//  Created by Soar on 2019/7/7.
//  Copyright © 2019 Soar. All rights reserved.
//

import Foundation
import UIKit
//import CoreData


let AQI_URL = "http://opendata.epa.gov.tw/webapi/Data/REWIQA/?$orderby=Longitude,Latitude&$skip=0&format=json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

struct AQI: Codable {
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

let dailyURL = "http://www.swibeat.com/mobile_test/dailyquote_xpath.php".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

struct Daily: Codable {
    var Txt:String?
    var Title:String?
    var Time:String?
    
    enum CodingKeys: String, CodingKey {
        case Txt = "Txt"
        case Title = "Title"
        case Time = "Time"
    }
}
