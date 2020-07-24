//
//  BaseNavigationController.swift
//  MoviesDB
//
//  Created by Federico Torres on 19/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            guard oldValue != statusBarStyle else { return }
            UIView.animate(withDuration: 0.3) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
}

extension UIViewController {
    func inBaseNavigation() -> BaseNavigationController {
        return BaseNavigationController(rootViewController: self)
    }
}

extension UIViewController {
    func setNavigationBarTransparent(_ transparent: Bool) {
        if transparent {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = .clear
            self.edgesForExtendedLayout = UIRectEdge.top
            
            navigationController?.setNeedsStatusBarAppearanceUpdate()
        } else {
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.view.backgroundColor = .white
            
            navigationController?.setNeedsStatusBarAppearanceUpdate()
        }
    }
}
