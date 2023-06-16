//
//  FavoriteQuotesDataManager.swift
//  Technical-test
//
//  Created by Користувач on 15.06.2023.
//

import Foundation

protocol FavoriteQuotesDataManagerProtocol {
    func add(quote: Quote)
    func remove(quote: Quote)
    func isFavorite(quote: Quote) -> Bool
}

class FavoriteQuotesDataManager: FavoriteQuotesDataManagerProtocol {
    
    @UserDefault(key: "favorites_quotes_ids", defaultValue: [])
    private var favoritesIDs: [String]
    
    init() {
        print(favoritesIDs)
    }
    
    func add(quote: Quote) {
        favoritesIDs.append(quote.id)
        print(favoritesIDs)
    }
    
    func remove(quote: Quote) {
        guard let index = favoritesIDs.firstIndex(of: quote.id) else { return }
        favoritesIDs.remove(at: index)
        print(favoritesIDs)
    }
    
    func isFavorite(quote: Quote) -> Bool {
        favoritesIDs.contains(quote.id)
    }
}
