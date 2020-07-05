//
//  ViewController.swift
//  MoviesDB
//
//  Created by Federico Torres on 04/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

     override func viewDidLoad() {
         super.viewDidLoad()
         // Do any additional setup after loading the view.
         view.backgroundColor = .white
         setupConstraints()
     }
     
     private func setupConstraints() {
        let mainView = MainView(viewModel: HomeViewModelImpl(), frame: view.bounds)
         view.addSubview(mainView)
     }


}

