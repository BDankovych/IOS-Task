//
//  QuotesListCell.swift
//  Technical-test
//
//  Created by Користувач on 15.06.2023.
//

import UIKit

class QuotesListCell: UITableViewCell {
    // UI
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var lastCurrencyLabel: UILabel!
    @IBOutlet private var readableLastChangePercentLabel: UILabel!
    @IBOutlet private var isFacoriteButton: UIButton!
    
    // Data
    private var quote: Quote!
    
    override func prepareForReuse() {
        nameLabel.text = ""
        lastCurrencyLabel.text = ""
        readableLastChangePercentLabel.text = ""
        isFacoriteButton.setImage(UIImage(systemName: "no-favorite"), for: .normal)
    }
    
    func configure(model: Quote) {
        self.quote = model
        nameLabel.text = quote.name ?? "--"
        if let last = quote.last, let currency = quote.currency {
            lastCurrencyLabel.text = String(format: "%@ %@", last, currency)
        } else {
            lastCurrencyLabel.text = "--"
        }
        
        if let readableLastChangePercent = quote.readableLastChangePercent {
            readableLastChangePercentLabel.text = readableLastChangePercent
            readableLastChangePercentLabel.textColor = getVariationColor(quote.variationColor)
        } else {
            readableLastChangePercentLabel.text = "-- %"
            readableLastChangePercentLabel.textColor = .black
        }
    }
    
    private func getVariationColor(_ variation: String?) -> UIColor {
        switch variation {
        case "red": return .red
        case "green": return .green
        default: return .black
        }
    }
}
