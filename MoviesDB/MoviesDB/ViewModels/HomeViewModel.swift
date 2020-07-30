//
//  ViewModel.swift
//  MoviesDB
//
//  Created by Federico Torres on 04/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModel {
    func loadMore()
    func getMovies(category: Movie.Category, page: Int?) -> Single<[Movie]>
    func getMoviesDriver() -> Driver<HomeState>
    func initialize()
}
