//
//  HomeBuilder.swift
//  MoviesDB
//
//  Created by Federico Torres on 24/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import UIKit

final class HomeBuilder{
    func build() -> UIViewController {
        let viewModel = HomeViewModelImpl()
        let viewController = MainViewController(viewModel: viewModel, nibName: "ContainerView")
        return viewController
    }
}


