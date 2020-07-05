//
//  ViewModel.swift
//  MoviesDB
//
//  Created by Federico Torres on 04/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewModel {
    func getMovies(category: Movie.Category, page: Int?) -> Single<[Movie]>
    
}
