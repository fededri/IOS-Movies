//
//  ResultsViewController.swift
//  MoviesDB
//
//  Created by Federico Torres on 19/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import UIKit

class ResultsViewController : BaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "MovieCell"
    var data : [String] = []
    private let viewModel : HomeViewModel!
    
    // MARK: - Init -
    init(viewModel : HomeViewModel, nibName: String? = nil){
        self.viewModel = viewModel
        super.init(nibName: nibName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableViewCellNib = UINib(nibName: "CellViewXib", bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension ResultsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CellView
        
        cell.setTitle(title: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

extension ResultsViewController : UITableViewDelegate {
    
}

