//
//  NetworkConstants.swift
//  MoviesDB
//
//  Created by Federico Torres on 05/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation

struct NetworkConstants {
    private init() {}
    
    
    static var baseURL: String { return "https://api.themoviedb.org/3" }
    static var apiKey: String { return "f2dd2ffff4c39e0f8005172a7b1e823d" }
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}
