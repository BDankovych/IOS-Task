//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

class QuotesListViewController: UIViewController {
    private let dataManager: DataManageProtocol = DataManager()
    private var market: Market? = nil
    private var quetes: [Quote] = []
    
    // UI
    private let tableView = UITableView()
    
    // MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        dataManager.fetchQuotes { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let quotes):
                self.quetes = quotes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.display(error: error)
            }
        }
    }
    
    private func setupView() {
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
}

// MARK: - TableViewDataSource
extension QuotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quetes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(type: QuotesListCell.self, indexPath: indexPath)
        cell.configure(model: quetes[indexPath.row])
        return cell
    }
}

// MARK: - TableViewDelegate
extension QuotesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let quote = quetes[indexPath.row]
        let vc = QuoteDetailsViewController(quote: quote)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
