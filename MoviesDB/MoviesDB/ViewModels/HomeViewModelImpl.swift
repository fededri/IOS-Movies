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
    
    private let apiClient : ApiClient = ApiClient() //TODO this should be a Singleton
    
    private let uiStateSubject  =  PublishSubject<[Movie]>()
    private let disposeBag = DisposeBag()
    
    
    func initialize(){
        getMovies(category: .popular, page: 1)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { movies  in
                self.uiStateSubject.onNext(movies)
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getMoviesDriver() -> Driver<[Movie]>{
        return uiStateSubject.asDriver(onErrorJustReturn: [])
    }
    
    
    func getMovies(category: Movie.Category, page: Int?) -> Single<[Movie]> {
        let value : Int = page ?? 1
        
        return apiClient.getMovies(category: category, page: value)
            .map({$0.results})
    }
}
