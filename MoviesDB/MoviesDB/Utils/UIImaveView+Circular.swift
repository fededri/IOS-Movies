//
//  UIImaveView+Circular.swift
//  MoviesDB
//
//  Created by Federico Torres on 27/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import UIKit


extension UIImageView {
    func makeCircular(){
        layer.cornerRadius = bounds.width / 2
    }
}
