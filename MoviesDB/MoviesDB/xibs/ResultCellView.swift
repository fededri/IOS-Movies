//
//  ResultCellView.swift
//  MoviesDB
//
//  Created by Federico Torres on 26/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import UIKit

class ResultCellView : UITableViewCell {
 
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    func configure(movie: Movie) {
        movieImageView.makeCircular()
        movieImageView.kf.setImage(with: URL(string: movie.posterPath!))
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
    }
    
}
