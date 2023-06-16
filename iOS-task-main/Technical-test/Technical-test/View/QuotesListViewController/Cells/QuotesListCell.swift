//
//  QuotesListCell.swift
//  Technical-test
//
//  Created by Користувач on 15.06.2023.
//

import UIKit

protocol QuotesListCellDelegate: AnyObject {
    func changeQuoteState(quoteID: String, isFavorite: Bool)
}

class QuotesListCell: UITableViewCell {
    // UI
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var lastCurrencyLabel: UILabel!
    @IBOutlet private var readableLastChangePercentLabel: UILabel!
    @IBOutlet private var isFacoriteButton: UIButton!
    
    // Data
    private var quote: QuotesListCellDTO!
    
    // Delegate
    weak var delegate: QuotesListCellDelegate?
    
    override func prepareForReuse() {
        nameLabel.text = ""
        lastCurrencyLabel.text = ""
        readableLastChangePercentLabel.text = ""
        isFacoriteButton.setImage(UIImage(named: "no-favorite"), for: .normal)
    }
    
    func configure(model: QuotesListCellDTO) {
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
        
        setupFavoriteButton()
    }
    
    
    //MARK: - private
    private func setupFavoriteButton() {
        let iconName = quote.isFavorite ? "favorite" : "no-favorite"
        isFacoriteButton.setImage(UIImage(named: iconName), for: .normal)
    }
    
    private func getVariationColor(_ variation: String?) -> UIColor {
        switch variation {
        case "red": return .red
        case "green": return .green
        default: return .black
        }
    }
    
    //MARK: - Actions
    @IBAction func favoriteButtonPressed() {
        quote.isFavorite.toggle()
        delegate?.changeQuoteState(quoteID: quote.id, isFavorite: quote.isFavorite)
        setupFavoriteButton()
    }
}
