//
//  HomeState.swift
//  MoviesDB
//
//  Created by Federico Torres on 28/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation


struct HomeState{
    var movies : [Movie] = []
    var isLoading: Bool = false
    var page : Int = 1
}
