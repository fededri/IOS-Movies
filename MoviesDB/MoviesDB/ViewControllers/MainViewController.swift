//
//  ViewController.swift
//  MoviesDB
//
//  Created by Federico Torres on 04/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController {
    
    var searchController = UISearchController(searchResultsController: nil)
    let cellIdentifier = "MovieCell"
    var resultsController : ResultsViewController!
    private let viewModel : HomeViewModel!
    private let disposeBag = DisposeBag()
    
    var data : [Movie] = []
    
    var filteredData: [Movie] = []
    private var isSearching : Bool = false
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Init
    init(viewModel : HomeViewModel, nibName: String? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        startListeningState()
        viewModel.initialize()
        self.title = "Movies Demo"
        let tableViewCellNib = UINib(nibName: "CellViewXib", bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
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
    
    private func startListeningState(){
        viewModel.getMoviesDriver()
            .drive(onNext: { (state) in
                self.updateUI(state: state)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUI(state: HomeState){
        self.data = state.movies
        self.tableView.reloadData()
    }
    
    
}

// MARK: - UITableViewDelegate
extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //Check if reached bottom
        if(indexPath.row == data.count - 1){
            self.viewModel.loadMore()
        }
        
        
        cell.contentView.layer.masksToBounds = true
        
        //Run animation
        let scaleFactor : CGFloat = 0.6
        cell.transform = CGAffineTransform.identity.scaledBy(x: scaleFactor, y: scaleFactor)
        cell.alpha = 0.5
        UIView.animate(withDuration: 0.3) {
            cell.transform = .identity
            cell.alpha = 1.0
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CellView
        
        cell.configure(with: data[indexPath.row])
        cell.configureBorders()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

// MARK: - UISearchResultsUpdating
extension MainViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let newText  = searchController.searchBar.text{
            if(!newText.isEmpty){
                filteredData = data.filter { $0.title.lowercased().contains(newText.lowercased())}
                
                if let resultsController = searchController.searchResultsController as? ResultsViewController {
                    
                    //TODO
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
