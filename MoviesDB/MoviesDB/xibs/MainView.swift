//
//  MainView.swift
//  MoviesDB
//
//  Created by Federico Torres on 04/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import UIKit
import Foundation

class MainView: UIView, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = "CellView"
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
        "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
        "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
        "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
        "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    var filteredData: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    
    
    private func customInit(){
        let nib = UINib(nibName: "MainView", bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.backgroundColor = UIColor.clear
            addSubview(view)
            view.frame = self.bounds
            self.backgroundColor = UIColor.cyan
        }
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.register(CellView.self, forCellReuseIdentifier: cellId)
        let myNib = UINib(nibName: "CellViewXib", bundle: nil)
        tableView.register(myNib, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CellView
       
        cell.setTitle(title: data[indexPath.row])
        //cell.setTitle(title: filteredData[indexPath.row])
              return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
                  return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
              }
        dump(filteredData)
        tableView.reloadData()
    }
    

}
