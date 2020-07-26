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
    
    private func setupConstraints() {
        let mainView = MainView(viewModel: viewModel, frame: view.bounds)
        view.addSubview(mainView)
    }
    
    private func startListeningState(){
        viewModel.getMoviesDriver()
            .drive(onNext: { (movies) in
                self.updateUI(state: movies)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateUI(state: [Movie]){
        self.data = state
        self.tableView.reloadData()
    }
    
    
}

// MARK: - UITableViewDelegate
extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
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
                filteredData = data.filter { $0.title.contains(newText)}
                
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
