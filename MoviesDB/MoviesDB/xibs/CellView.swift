//
//  CellView.swift
//  MoviesDB
//
//  Created by Federico Torres on 04/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation
import UIKit

class CellView : UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    
    func setTitle(title: String){
        labelTitle.text = title
    }
    
    
}
