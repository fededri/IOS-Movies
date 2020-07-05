//
//  ApiClient.swift
//  MoviesDB
//
//  Created by Federico Torres on 05/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift


class ApiClient{


    func getMovies(category: Movie.Category, page: Int) -> Single<PagedMoviesResponse>{
        return request(ApiRouter.getMovies(category: category, page: page))
    }
    
    func request<T : Codable>(_ urlConvertible: URLRequestConvertible) -> Single<T> {
        return Single<T>.create{ observable in
            let request = AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result{
                case .success(let value):
                    observable(.success(value))
                case .failure(let error):
                    observable(.error(error))
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
