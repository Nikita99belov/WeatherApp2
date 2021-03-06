//
//  SearchTabelViewController.swift
//  
//
//  Created by Sofi on 05.03.2021.
//

import UIKit

class SearchViewController: UITableViewController {
    
    let citis = City.getListOfTeam()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCity:[City] = []
    var serarchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !serarchBarIsEmpty
    }
    var citisDelegat: SetengViewColorDelegat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCity.count
        }
        return citis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath)
        var citys: City
        
        if isFiltering {
            citys = filteredCity[indexPath.row]
        } else  {
            citys = citis[indexPath.row]
        }
        var content = cell.defaultContentConfiguration()
        content.text = citys.name
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
        var citys: City
        if isFiltering {
            citys = filteredCity[indexPath.row]
        } else  {
            citys = citis[indexPath.row]
        }
        citisDelegat.citydelegat(city: citys)
        dismiss(animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCity = citis.filter({ (citys: City) -> Bool in
            return citys.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}


