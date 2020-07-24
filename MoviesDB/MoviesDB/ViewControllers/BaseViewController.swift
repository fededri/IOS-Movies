//
//  BaseViewController.swift
//  MoviesDB
//
//  Created by Federico Torres on 24/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation
import UIKit


class BaseViewController : UIViewController{
    
    // MARK: - Init -
      init(nibName: String? = nil) {
          let name = String(describing: type(of: self))
          super.init(nibName: nibName ?? name, bundle: nil)
      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError()
      }
}
