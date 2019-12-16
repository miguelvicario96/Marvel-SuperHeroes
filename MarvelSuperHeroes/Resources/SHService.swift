//
//  SHService.swift
//  MarvelSuperHeroes
//
//  Created by Miguel Vicario on 11/14/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

public enum ParseResult <T, Error> {
    case success(T)
    case failure(Error)
}

public class SHService {
    
    //MARK: - Static Properties
    public static let shared = SHService()
    
    //MARK: - Instance Properties
    //MARVEL SUPERHEROES ENDPOINT
    private let url = URL(string: "https://api.myjson.com/bins/bvyob")
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        config.timeoutIntervalForResource = 20.0
        return URLSession(configuration: config)
    }()

    //MARK: - Object Lifecycle
    private init() {}
    
    //MARK: - Instance Methods
    public func serviceCall(completion: @escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            DispatchQueue.main.async { completion(data,error) }
        }
        task.resume()
    }
    
    public func parsingResult <T: Codable> (_ object: T.Type, data: Data?, error: Error?) -> ParseResult <T,Error> {
        guard let data = data else { return .failure(error!) }
        do {
            let result = try JSONDecoder().decode(object, from: data)
            return .success(result)
        } catch (let error) {
            return .failure(error)
        }
    }
}
