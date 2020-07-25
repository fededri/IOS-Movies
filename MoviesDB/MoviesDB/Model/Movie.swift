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
    
    let aPosterPath: String?
    var posterPath: String? {
        guard let _posterPath = aPosterPath else {
            return nil
        }
        return "https://image.tmdb.org/t/p/w500\(_posterPath)"
    }
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    let id: Int
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String?
    let popularity: Double
    let video: Bool
    let voteAverage: Double
    
    init(
        posterPath: String?,
        adult: Bool,
        overview: String,
        releaseDate: Date,
        genreIds: [Int],
        id: Int,
        originalTitle: String,
        originalLanguage: String,
        title: String,
        backdropPath: String?,
        popularity: Double,
        video: Bool,
        voteAverage: Double
    ) {
        self.aPosterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = ""
        self.genreIds = genreIds
        self.id = id
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.popularity = popularity
        self.video = video
        self.voteAverage = voteAverage
    }
    
    enum CodingKeys: String, CodingKey {
        case aPosterPath = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id = "id"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title = "title"
        case backdropPath = "backdrop_path"
        case popularity = "popularity"
        case video = "video"
        case voteAverage = "vote_average"
    }
}
