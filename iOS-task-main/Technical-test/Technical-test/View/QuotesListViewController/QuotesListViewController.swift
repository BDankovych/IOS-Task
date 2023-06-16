//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

class QuotesListViewController: HUDViewController {
    private let favoritesManager: FavoriteQuotesDataManagerProtocol = FavoriteQuotesDataManager()
    private let dataManager: DataManageProtocol = DataManager()
    private var quotes: [Quote] = []
    
    // UI
    private let tableView = UITableView()
    
    // MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        laodData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - private
    private func setupView() {
        title = "Quote's list"
        view.backgroundColor = .lightGray
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        tableView.register(QuotesListCell.self)
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func laodData() {
        showLoading()
        dataManager.fetchQuotes { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let quotes):
                self.quotes = quotes
                DispatchQueue.main.async {
                    self.hideLoading()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.display(error: error)
            }
        }
    }
}

// MARK: - TableViewDataSource
extension QuotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(type: QuotesListCell.self, indexPath: indexPath)
        let quote = quotes[indexPath.row]
        let isFavorite = favoritesManager.isFavorite(quote: quote)
        
        let dto = QuotesListCellDTO(
            name: quote.name,
            currency: quote.currency,
            readableLastChangePercent: quote.readableLastChangePercent,
            last: quote.last,
            variationColor: quote.variationColor,
            isFavorite: isFavorite
        )
        
        cell.delegate = self
        cell.configure(model: dto)
        return cell
    }
}

// MARK: - TableViewDelegate
extension QuotesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let quote = quotes[indexPath.row]
        let vc = QuoteDetailsViewController(quote: quote, favoritesManager: favoritesManager)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension QuotesListViewController: QuotesListCellDelegate {
    func changeQuoteState(quoteID: String, isFavorite: Bool) {
        guard let quote = quotes.first(where: {$0.id.contains(quoteID) }) else { return }
        if isFavorite {
            favoritesManager.add(quote: quote)
        } else {
            favoritesManager.remove(quote: quote)
        }
    }
}

