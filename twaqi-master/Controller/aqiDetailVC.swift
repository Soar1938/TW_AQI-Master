//
//  aqiDetailVC.swift
//  twaqi-master
//
//  Created by Soar on 2019/7/7.
//  Copyright © 2019 Soar. All rights reserved.
//

import UIKit

class aqiDetailVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var aqiData :[Aqi_List]?
    var indexRow : Int?
    var aqi:Int?
    var bgColor : UIColor?
    var txtColor : UIColor?
    /*
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
    */
    
    @IBOutlet weak var aqiDetailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.aqi = Int(self.aqiData![indexRow!].aqi) //?? -1
        
        self.bgColor = backgroundColor(aqiVal: self.aqi!)
        self.txtColor = LableTxtColor(aqiVal: self.aqi!)
        aqiDetailTableView.backgroundColor = self.bgColor
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! aqiDetailCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = self.bgColor
        cell.TitleLabel.text = ""
        cell.ValueLabel.text = ""
        cell.TitleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        cell.ValueLabel.font = UIFont(name: "HelveticaNeue", size: 24)
        cell.TitleLabel.textAlignment = NSTextAlignment.left
        cell.ValueLabel.textAlignment = NSTextAlignment.right
        cell.TitleLabel.textColor = self.txtColor
        cell.ValueLabel.textColor = self.txtColor
        
        switch indexPath.row {
        case 0:
            cell.TitleLabel.text = "縣市"
            cell.ValueLabel.text = self.aqiData![indexRow!].county! + " - " + self.aqiData![indexRow!].sitename!
            
        case 1:
            cell.TitleLabel.text = "發布時間"
            cell.ValueLabel.text = self.aqiData![indexRow!].publishtime!
            
        case 2:
            cell.TitleLabel.text = "狀態"
            cell.ValueLabel.text = self.aqiData![indexRow!].status!
            
        case 3:
            cell.TitleLabel.text = "空氣品質指標"
            cell.ValueLabel.text = String(self.aqiData![indexRow!].aqi)
        
        case 4:
            cell.TitleLabel.text = "臭氧"
            cell.ValueLabel.text = String(self.aqiData![indexRow!].o3)
            
        case 5:
            cell.TitleLabel.text = "PM2.5"
            cell.ValueLabel.text = String(self.aqiData![indexRow!].pm25)
            
        case 6:
            cell.TitleLabel.text = "PM10"
            cell.ValueLabel.text = String(self.aqiData![indexRow!].pm10)
            
        case 7:
            cell.TitleLabel.text = "一氧化碳(ppm)"
            cell.ValueLabel.text = String(self.aqiData![indexRow!].co)
            
        case 8:
            cell.TitleLabel.text = "二氧化硫(ppb)"
            cell.ValueLabel.text = String(self.aqiData![indexRow!].so2)
            
        case 9:
            cell.TitleLabel.text = "二氧化氮"
            cell.ValueLabel.text = String(self.aqiData![indexRow!].no2)
            
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
    
    func backgroundColor(aqiVal: Int) -> UIColor {
        if aqiVal >= 0 && aqiVal <= 50 {
            return UIColor.init(displayP3Red: 0/255, green: 232/255, blue: 0/255, alpha: 1.0)
        }else if aqiVal > 50  && aqiVal <= 100{
            return UIColor.init(displayP3Red: 255/255, green: 255/255, blue: 0/255, alpha: 1.0)
        }else if aqiVal > 100 && aqiVal <= 150{
            return UIColor.init(displayP3Red: 255/255, green: 126/255, blue: 0/255, alpha: 1.0)
        }else if aqiVal > 150 && aqiVal <= 200 {
            return UIColor.init(displayP3Red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }else if aqiVal > 200 && aqiVal <= 300 {
            return UIColor.init(displayP3Red: 143/255, green: 63/255, blue: 151/255, alpha: 1.0)
        }else if aqiVal > 300 {
            return UIColor.init(displayP3Red: 125/255, green: 0/255, blue: 35/255, alpha: 1.0)
        }else if aqiVal == -1 {
            return UIColor.init(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }else {
            return UIColor.init(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }
    }
    
    func LableTxtColor(aqiVal: Int) -> UIColor {
        if aqiVal <= 150 {
            return UIColor.init(displayP3Red: 38/255, green: 38/255, blue: 38/255, alpha: 1.0)
        }else {
            return UIColor.init(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        }
    }
}
