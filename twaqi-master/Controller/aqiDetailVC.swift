//
//  aqiDetailVC.swift
//  twaqi-master
//
//  Created by Soar on 2019/7/7.
//  Copyright © 2019 Soar. All rights reserved.
//

import UIKit

class aqiDetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //var disc = [String: String]()
    var SiteName:String!
    var County:String!
    var AQI:String!
    var Pollutant:String!
    var Status:String!
    var SO2:String!
    var CO:String!
    var CO_8hr:String!
    var O3:String!
    var O3_8hr:String!
    var PM10:String!
    var PM25:String!
    var NO2:String!
    var NOx:String!
    var NO:String!
    var WindSpeed:String!
    var WindDirec:String!
    var PublishTime:String!
    var PM25_AVG:String!
    var PM10_AVG:String!
    var SO2_AVG:String!
    var Longitude:String!
    var Latitude:String!

    
    @IBOutlet weak var aqiDetailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let aqi:Int = Int(AQI) ?? -1
        aqiDetailTableView.backgroundColor = backgroundColor(aqiIndex: Int(aqi))
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! aqiDetailCell
        
        let aqi:Int = Int(AQI) ?? -1
        cell.backgroundColor = backgroundColor(aqiIndex: Int(aqi))
        cell.TitleLabel.text = ""
        cell.ValueLabel.text = ""
        //cell.aqiDetailCell.backgroundColor = backgroundColor(aqiIndex: Int(aqi))
        cell.TitleLabel.font = UIFont(name: "Helvetica-Light", size: 24)
        cell.ValueLabel.font = UIFont(name: "Helvetica-Light", size: 24)
        cell.TitleLabel.textAlignment = NSTextAlignment.right
        cell.ValueLabel.textAlignment = NSTextAlignment.left
        switch indexPath.row {
        case 0:
            cell.TitleLabel.text = "縣市"
            cell.ValueLabel.text = County + " - " + SiteName
            cell.ValueLabel.font = UIFont(name: "Helvetica-Light", size: 20)
            
        case 1:
            cell.TitleLabel.text = "空氣品質指標"
            cell.ValueLabel.text = AQI
            
        case 2:
            cell.TitleLabel.text = "狀態"
            cell.ValueLabel.text = Status
            
        case 3:
            cell.TitleLabel.text = "臭氧"
            cell.ValueLabel.text = O3
            
        case 4:
            cell.TitleLabel.text = "PM2.5"
            cell.ValueLabel.text = PM25
            
        case 5:
            cell.TitleLabel.text = "PM10"
            cell.ValueLabel.text = PM10
            
        case 6:
            cell.TitleLabel.text = "PM10"
            cell.ValueLabel.text = PM10
            
        case 7:
            cell.TitleLabel.text = "一氧化碳(ppm)"
            cell.ValueLabel.text = CO
            
        case 8:
            cell.TitleLabel.text = "二氧化硫(ppb)"
            cell.ValueLabel.text = SO2
            
        case 9:
            cell.TitleLabel.text = "二氧化氮"
            cell.ValueLabel.text = NO2
            
        case 10:
            cell.TitleLabel.text = "發布時間"
            cell.ValueLabel.text = PublishTime
            cell.ValueLabel.font = UIFont(name: "Helvetica-Light", size: 18)
            
        default:
            cell.TitleLabel.text = ""
            cell.ValueLabel.text = ""
            
        }
        return cell
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - methods
extension aqiDetailVC {
    
    func backgroundColor(aqiIndex: Int) -> UIColor {
        if aqiIndex >= 0 && aqiIndex <= 50 {
            return UIColor.init(displayP3Red: 0/255, green: 232/255, blue: 0/255, alpha: 1.0)
        }else if aqiIndex > 50  && aqiIndex <= 100{
            return UIColor.init(displayP3Red: 255/255, green: 255/255, blue: 0/255, alpha: 1.0)
        }else if aqiIndex > 100 && aqiIndex <= 150{
            return UIColor.init(displayP3Red: 255/255, green: 126/255, blue: 0/255, alpha: 1.0)
        }else if aqiIndex > 150 && aqiIndex <= 200 {
            return UIColor.init(displayP3Red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }else if aqiIndex > 200 && aqiIndex <= 300 {
            return UIColor.init(displayP3Red: 143/255, green: 63/255, blue: 151/255, alpha: 1.0)
        }else if aqiIndex > 300 {
            return UIColor.init(displayP3Red: 125/255, green: 0/255, blue: 35/255, alpha: 1.0)
        }else if aqiIndex == -1 {
            return UIColor.init(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }else {
            return UIColor.init(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }
    }
}
