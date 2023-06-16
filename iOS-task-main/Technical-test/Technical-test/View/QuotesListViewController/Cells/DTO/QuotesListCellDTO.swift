//
//  QuotesListCellDTO.swift
//  Technical-test
//
//  Created by Користувач on 15.06.2023.
//

import Foundation

struct QuotesListCellDTO {
    var name: String?
    var currency: String?
    var readableLastChangePercent: String?
    var last: String?
    var variationColor: String?
    var isFavorite: Bool
}

extension QuotesListCellDTO: Equatable {
    var id: String {
        (name ?? "") + "_" + (currency ?? "")
    }
}
