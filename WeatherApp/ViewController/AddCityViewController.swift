//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Sofi on 01.03.2021.
//

import UIKit

class AddCityViewController:  UITableViewController {
    
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var addText: UITextField!
    
    var cityes = DataSorse.city
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityName", for: indexPath)
        
        let citys = cityes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = citys
        cell.contentConfiguration = content
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let controller = segue.destination as? WeatherViewController
            let index = cityes[indexPath.row]
            let replacedCitis = index.replacingOccurrences(of: " ", with: "%20")
            
            controller!.citis = replacedCitis
            controller!.title = index
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        cityes.append(addText.text ?? "")
        tableView.reloadData()
        addText.text = nil
    }
}

