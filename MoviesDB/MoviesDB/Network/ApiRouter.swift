//
//  ApiRouter.swift
//  MoviesDB
//
//  Created by Federico Torres on 05/07/2020.
//  Copyright © 2020 Federico Torres. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    case getMovies(category: Movie.Category, page: Int)
    
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(NetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.acceptType.rawValue)
        
        urlRequest.setValue(NetworkConstants.ContentType.json.rawValue, forHTTPHeaderField: NetworkConstants.HttpHeaderField.contentType.rawValue)
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    
    //MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getMovies:
            return .get
        }
    }
    //MARK: - Path
    private var path: String {
        switch self {
        case .getMovies:
            return "/movie/popular"
        }
    }
    
    //MARK - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getMovies:
          return [
              "api_key"       : NetworkConstants.apiKey,
              "language"      : "en-US",
              "include_adult" : "false"
          ]
        }
    }
    
}
