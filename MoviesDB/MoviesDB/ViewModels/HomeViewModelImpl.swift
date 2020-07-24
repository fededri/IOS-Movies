//
//  MainViewModel.swift
//  MoviesDB
//
//  Created by Federico Torres on 04/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final public class HomeViewModelImpl : HomeViewModel {
    
    private let apiClient : ApiClient = ApiClient()
    
   
    
    func getMovies(category: Movie.Category, page: Int?) -> Single<[Movie]> {
        let value : Int = page ?? 1
    
        return apiClient.getMovies(category: category, page: value)
            .map({$0.results})
    }
}
