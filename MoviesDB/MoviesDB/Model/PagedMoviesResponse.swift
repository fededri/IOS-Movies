//
//  PagedMoviesResponse.swift
//  MoviesDB
//
//  Created by Federico Torres on 05/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation

final public class PagedMoviesResponse: Codable {
    let totalPages: Int
    let results: [Movie]
    let totalResults: Int
    let page: Int
    
    init(
        totalPages: Int,
        results: [Movie],
        totalResults: Int,
        page: Int
    ) {
        self.totalPages = totalPages
        self.results = results
        self.totalResults = totalResults
        self.page = page
    }
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case results = "results"
        case totalResults = "total_results"
        case page = "page"
    }
}
