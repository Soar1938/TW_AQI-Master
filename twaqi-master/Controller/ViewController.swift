//
//  ViewController.swift
//  twaqi-master
//
//  Created by Soar on 2019/7/7.
//  Copyright © 2019 Soar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var aqiTableView: UITableView!
    @IBOutlet weak var sentenceTxtView: UITextView!
    
    var aqiArray :[AQI]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        aqiTableView.dataSource = self
        aqiTableView.delegate = self
        
        //refreshControl = UIRefreshControl()
        //refreshControl.addTarget(self, action: #selector(updateData), for: UIControl.Event.valueChanged)
        //aqiTabelView.addSubview(refreshControl)
        
        //MARK: - fetch data in the first time
        getData()
    }
}

//MARK: - Fetch AQI Data
extension ViewController {
    
    func getData() {
        if let url = URL(string: AQI_URL!) {
            print("RESPONSE url: \(url)")
            let task = URLSession.shared.dataTask(with: url)
            {(data, response, error) in
                //print("RESPONSE FROM API: \(response)")
                let decoder = JSONDecoder()
                
                if let data = data , let result = try? decoder.decode([AQI].self, from: data){
                    print("RESPONSE FROM API: \(result)")
                    self.aqiArray = result
                    DispatchQueue.main.async {
                        self.aqiTableView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }
    
    @objc func updateData() {
        
        DispatchQueue.main.async {
            self.getData()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                //self.refreshControl.endRefreshing()
            }
        }
    }
}

//MARK: - TableView Setting
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if aqiArray != nil {
            return self.aqiArray!.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aqiCell", for: indexPath) as! aqiTableCell
        if aqiArray != nil {
            
            aqiArray?.reverse()
            cell.cityName.text = aqiArray![indexPath.row].SiteName!
            cell.aqiValue.text = aqiArray![indexPath.row].AQI!
            if cell.aqiValue.text == ""{
                cell.aqiValue.text = "暫無資料"
            }
            let aqi:Int = Int(aqiArray![indexPath.row].AQI!) ?? -1
            cell.aqiCellView.backgroundColor = backgroundColor(aqiIndex: aqi)
            return cell
        }else{
            
            //let errorCell = tableView.dequeueReusableCell(withIdentifier: "errorCell", for: indexPath)
            
            //return errorCell
            cell.cityName.text = ""
            cell.aqiValue.text = ""
            if cell.aqiValue.text == ""{
                cell.aqiValue.text = "暫無資料"
            }
            let aqi:Int = -1
            cell.aqiCellView.backgroundColor = backgroundColor(aqiIndex: aqi)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if aqiArray != nil {
            // aqiArray![indexPath.row].SiteName!
            //performSegue(withIdentifier: "showDetail", sender: self)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier=="showDetail" {
            if let indexPath = aqiTableView.indexPathForSelectedRow {
                let eng = segue.destination as! aqiDetailVC
                
                eng.SiteName = aqiArray![indexPath.row].SiteName!
                eng.County = aqiArray![indexPath.row].County!
                eng.AQI = aqiArray![indexPath.row].AQI!
                eng.Pollutant = aqiArray![indexPath.row].Pollutant!
                eng.Status = aqiArray![indexPath.row].Status!
                eng.SO2 = aqiArray![indexPath.row].SO2!
                eng.CO = aqiArray![indexPath.row].CO!
                eng.CO_8hr = aqiArray![indexPath.row].CO_8hr!
                eng.O3 = aqiArray![indexPath.row].O3!
                eng.O3_8hr = aqiArray![indexPath.row].O3_8hr!
                eng.PM10 = aqiArray![indexPath.row].PM10!
                eng.PM25 = aqiArray![indexPath.row].PM25!
                eng.NO2 = aqiArray![indexPath.row].NO2!
                eng.NOx = aqiArray![indexPath.row].NOx!
                eng.NO = aqiArray![indexPath.row].NO!
                eng.WindSpeed = aqiArray![indexPath.row].WindSpeed!
                eng.WindDirec = aqiArray![indexPath.row].WindDirec!
                eng.PublishTime = aqiArray![indexPath.row].PublishTime!
                eng.PM25_AVG = aqiArray![indexPath.row].PM25_AVG!
                eng.PM10_AVG = aqiArray![indexPath.row].PM10_AVG!
                eng.SO2_AVG = aqiArray![indexPath.row].SO2_AVG!
                eng.Longitude = aqiArray![indexPath.row].Longitude!
                eng.Latitude = aqiArray![indexPath.row].Latitude!
                
            }
        //2giijdli}
    }
}

//MARK: - methods
extension ViewController {
    
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
