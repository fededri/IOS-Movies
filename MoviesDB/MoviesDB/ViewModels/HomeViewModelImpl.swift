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
    
    private let uiStateSubject  =  PublishSubject<HomeState>()
    private var state  = HomeState()
    private let disposeBag = DisposeBag()
    
    
    func initialize(){
        getMovies(category: .popular, page: 1)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { movies  in
                self.state.movies = movies
                self.uiStateSubject.onNext(self.state)
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func getMoviesDriver() -> Driver<HomeState>{
        return uiStateSubject.asDriver(onErrorJustReturn: HomeState())
    }
    
    
    func getMovies(category: Movie.Category, page: Int?) -> Single<[Movie]> {
        let value : Int = page ?? 1
        
        return apiClient.getMovies(category: category, page: value)
            .map({$0.results})
    }
    
    
    func loadMore(){
        let nextPage = state.page + 1
        fetchMovies(category: .popular, page: nextPage)
    }
    
    
    // MARK - PRIVATE METHODS
    private func fetchMovies(category : Movie.Category, page : Int){
        print("Fetching page number \(page)")
        getMovies(category: category, page: page)
        .observeOn(MainScheduler.instance)
        .subscribe(onSuccess: { movies  in
            self.state.movies = self.state.movies +  movies
            self.state.page = page
            self.uiStateSubject.onNext(self.state)
        }, onError: { (error) in
            print(error)
        })
        .disposed(by: disposeBag)
    }
}
