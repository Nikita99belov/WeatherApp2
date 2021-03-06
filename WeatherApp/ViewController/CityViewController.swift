//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Sofi on 01.03.2021.
//

import UIKit
protocol SetengViewColorDelegat {
    
    func citydelegat (city: City)
}

class CityViewController:  UITableViewController {
    
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var addText: UITextField!
    
    var cityes : [City] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityName", for: indexPath)
        
        let citys = cityes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = citys.name
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
            cityes.remove(at: indexPath.row)
              tableView.deleteRows(at: [indexPath], with: .fade)
          
           }
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as? SearchViewController 
        settingsVC?.citisDelegat = self
        if let indexPath = tableView.indexPathForSelectedRow {
            let controller = segue.destination as? WeatherViewController
            let index = cityes[indexPath.row]
            let replacedCitis = index.name.replacingOccurrences(of: " ", with: "%20")
            print(index)
            controller!.citis = replacedCitis
            print(replacedCitis)
            controller!.title = index.name
        }
    }
}

extension CityViewController: SetengViewColorDelegat {
    func citydelegat(city: City) {
        guard !cityes.contains(city) else {
            return
        }
        cityes.append(city)
        tableView.reloadData()
    }
}
