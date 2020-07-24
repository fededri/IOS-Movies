//
//  ViewController.swift
//  MoviesDB
//
//  Created by Federico Torres on 04/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var searchController = UISearchController(searchResultsController: nil)
    let cellIdentifier = "MovieCell"
    var resultsController : ResultsViewController!
    let viewModel = HomeViewModelImpl() //TODO refactor
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData: [String] = []
    private var isSearching : Bool = false
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let tableViewCellNib = UINib(nibName: "CellViewXib", bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        resultsController = ResultsViewController(viewModel: viewModel,nibName: "ResultsView")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        
        searchController.searchBar.placeholder = "Search Movies"
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func setupConstraints() {
        let mainView = MainView(viewModel: viewModel, frame: view.bounds)
        view.addSubview(mainView)
    }
    
    
}

// MARK: - UITableViewDelegate
extension MainViewController : UITableViewDelegate {
    
    
}

// MARK: - UITableViewDataSource

extension MainViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CellView
        
        if(isSearching){
            cell.setTitle(title: filteredData[indexPath.row])
        } else {
            cell.setTitle(title: data[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearching){
            return filteredData.count
        } else {
            return data.count
        }
    }
}

// MARK: - UISearchResultsUpdating
extension MainViewController : UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
        if let newText  = searchController.searchBar.text{
            if(!newText.isEmpty){
                filteredData = data.filter { $0.contains(newText)}
                
                if let resultsController = searchController.searchResultsController as? ResultsViewController {
                    
                    resultsController.data = filteredData
                    resultsController.tableView.reloadData()
                }
                
                
            }
        }
    }
}


// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
}

// MARK: - UISearchControllerDelegate

// Use these delegate functions for additional control over the search controller.

extension MainViewController: UISearchControllerDelegate {
    
    func presentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
}
