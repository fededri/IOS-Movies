//
//  Movie.swift
//  MoviesDB
//
//  Created by Federico Torres on 05/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation

public struct Movie : Codable{
    public enum Category : String, CaseIterable {
        case popular, topRated, upcoming
        
        var displayableName : String {
            switch self {
            case .popular: return "Popular"
            case .topRated: return "Top Rated"
            case .upcoming: return "Upcoming"
            }
        }
    }
}
