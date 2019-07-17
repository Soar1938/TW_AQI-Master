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
    private var persistenceController: PersistenceController?
    // 創建一個列隊組合
    private let group = DispatchGroup()
    //var aqiArray :[AQI]?
    var aqiAy : [Aqi_List]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        aqiTableView.dataSource = self
        aqiTableView.delegate = self
        
        
        //MARK: - fetch data in the first time
        persistenceController = PersistenceController { [weak self] in
            self?.getData()
        }
        
    }
}

//MARK: - Fetch AQI Data
extension ViewController {
    
    func getData() {
        self.aqiAy =  self.persistenceController?.Aqi()
        let aqi_count: Int! = self.aqiAy?.count ?? 0
        self.aqiTableView.reloadData()
        if let url = URL(string: AQI_URL!) {
            let task = URLSession.shared.dataTask(with: url)
            {(data, response, error) in
                let decoder = JSONDecoder()
                
                if let data = data , let result = try? decoder.decode([AQI].self, from: data){
                    DispatchQueue.main.sync {
                        print("result count: \(result.count)")
                        if result.count > 0 {
                            if aqi_count > 0 {
                                if result[0].PublishTime != self.aqiAy![0].publishtime  {
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
                            } else {
                                for aqi in result {
                                    print("SiteName: \(aqi.SiteName!)")
                                    self.persistenceController?.createAqi(with: aqi)
                                }
                            }
                        }
                        print("Aqi Count: \(self.persistenceController?.Aqi().count as Int?)")
                        self.aqiAy?.removeAll()
                        self.aqiAy =  self.persistenceController?.Aqi()
                        self.aqiTableView.reloadData()
                        

                    }
                }
            }
            task.resume()
        }
    }
}

//MARK: - TableView Setting
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let count: Int! = self.persistenceController?.Aqi().count ?? 1
        //let count: Int! = self.aqiArray?.count ?? 1
        let count: Int! = self.aqiAy?.count ?? 1
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aqiCell", for: indexPath) as! aqiTableCell
        
        cell.selectionStyle = .none
        if self.aqiAy != nil {
            
            // self.aqiAy?.reverse()
            cell.cityName.text = self.aqiAy![indexPath.row].sitename!
            cell.aqiValue.text = String(self.aqiAy![indexPath.row].aqi)
            if cell.aqiValue.text == ""{
                cell.aqiValue.text = "暫無資料"
            }
            let aqi:Int = Int(self.aqiAy![indexPath.row].aqi)
            cell.aqiCellView.backgroundColor = backgroundColor(aqiIndex: aqi)
            return cell
        }else{
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
        
        if self.aqiAy == nil {
            return
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        let deleteAction = UITableViewRowAction(style: .default, title: "刪除") {
            
            action, index in
            self.aqiAy!.remove(at: index.row)
            self.aqiTableView.reloadData()
        }
        
        self.persistenceController?.delete(self.aqiAy![indexPath.row]) { [weak self] in
            print("Number of authors after delete: \(String(describing: self?.persistenceController?.Aqi().count))")
        }
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if self.aqiAy != nil {
            if let indexPath = self.aqiTableView.indexPathForSelectedRow {
                print("indexPath Row = \(indexPath.row)")
                let eng = segue.destination as! aqiDetailVC
                
                eng.aqiData     = self.aqiAy!
                eng.indexRow    = indexPath.row
                
            }
        }
    }
}

//MARK: - methods
extension ViewController {
    
    func backgroundColor(aqiIndex: Int) -> UIColor {
        if aqiIndex > 0 && aqiIndex <= 50 {
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
        }else if aqiIndex == 0 {
            return UIColor.init(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }else {
            return UIColor.init(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        }
    }
}
