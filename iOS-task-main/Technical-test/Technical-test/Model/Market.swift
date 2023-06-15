//
//  Market.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 30.04.21.
//

import Foundation

class Market: Decodable {
    let marketName: String = "SMI"
    var quotes: [Quote]? = []
    
    enum CodingKeys: CodingKey {
        case quotes
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.quotes = try container.decodeIfPresent([Quote].self, forKey: .quotes)
    }
}
