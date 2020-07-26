//
//  CellView.swift
//  MoviesDB
//
//  Created by Federico Torres on 04/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CellView : UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var cellContainerView: UIView!
    
    //MARK - Configuration
    
    func configure(with movie: Movie) {
        setTitle(title: movie.title)
        descriptionLabel.text = movie.overview
        
        
        if let path = movie.posterPath {
            let url = URL(string: path)
            movieImageView.kf.setImage(with: url, options: [.transition(.fade(0.25))])
        }
    }
    
    func setTitle(title: String){
        labelTitle.text = title
    }
    
    
    func configureBorders() {
        backgroundColor = .clear // very important
        
        // add corner radius on `contentView`
        cellContainerView.layer.cornerRadius = 12.0
        cellContainerView.layer.borderWidth = 2.0
        cellContainerView.layer.borderColor = UIColor.clear.cgColor
        cellContainerView.layer.masksToBounds = true
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.53
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
       
  
    }
}
