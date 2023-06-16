//
//  DataManager.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

protocol DataManageProtocol {
    func fetchQuotes(completionHandler: @escaping (Result<[Quote], Error>) -> Void)
}


class DataManager: DataManageProtocol {
    
    private static let path = "https://www.swissquote.ch/mobile/iphone/Quote.action?formattedList&formatNumbers=true&listType=SMI&addServices=true&updateCounter=true&&s=smi&s=$smi&lastTime=0&&api=2&framework=6.1.1&format=json&locale=en&mobile=iphone&language=en&version=80200.0&formatNumbers=true&mid=5862297638228606086&wl=sq"
    
    
    func fetchQuotes(completionHandler: @escaping (Result<[Quote], Error>) -> Void) {
        guard let url = URL(string: Self.path) else {
            completionHandler(.failure(ErrorTypes.wrongUrl))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data else {
                completionHandler(.failure(ErrorTypes.unknown))
                return
            }
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                completionHandler(.success(quotes))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}

extension DataManager {
    enum ErrorTypes: LocalizedError {
        case wrongUrl
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .wrongUrl:
                return "Something wrong with your url requst"
            case .unknown:
                return "Unknown error. Please try later"
            }
        }
    }
}
