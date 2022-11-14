//
//  CartoonsList_View.swift
//  Cartoons
//
//  Created by Supapon Pucknavin on 13/11/2565 BE.
//

import Foundation
import UIKit

// Talks to presenter
protocol CartoonsList_View_Protocol {
    var presenter: CartoonsList_Presenter_Protocol? {get set}
    
    func update(with cartoons:[Cartoon])
    func update(with error:String)
}


class CartoonsListViewController: UIViewController, CartoonsList_View_Protocol {


    // MARK: - COMPONENT
    private let tableView: UITableView = UITableView()
    private let messageLabel: UILabel = UILabel()
    
    
    // MARK: - PROPERTY
    var presenter: CartoonsList_Presenter_Protocol?
    var cartoons: [Cartoon] = []
   
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let seledtIndex = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: seledtIndex, animated: true)
        }
    }
}

extension CartoonsListViewController {
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.isHidden = false
        messageLabel.text = "Loading..."
        messageLabel.font = UIFont.systemFont(ofSize: 20)
        messageLabel.textColor = .black
        messageLabel.textAlignment = .center
        
    }
    
    func layout() {
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        // tableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        
        // messageLabel
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}

// MARK: - CartoonsList_View_Protocol
extension CartoonsListViewController {
    func update(with cartoons: [Cartoon]) {
        DispatchQueue.main.async { [weak self] in
            self?.cartoons = cartoons
            self?.messageLabel.isHidden = true
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
 
        DispatchQueue.main.async { [weak self] in
            self?.cartoons = []
            self?.tableView.isHidden = true
            
            self?.messageLabel.isHidden = false
            self?.messageLabel.text = error
        }
    }
}

// MARK: - UITableViewDelegate
extension CartoonsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.tapOnDetail(cartoons[indexPath.row])
        
    }
}

// MARK: - UITableViewDataSource
extension CartoonsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartoons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        var content = cell.defaultContentConfiguration()
        content.text = cartoons[indexPath.row].title
        content.secondaryText = "\(cartoons[indexPath.row].year)"
        cell.contentConfiguration = content
        return cell
    }
    
    
}

// MARK: - Unit Testing
extension CartoonsListViewController {
    func errorMessageForTesting() -> String? {
        return messageLabel.text
    }
    
    func errorLabelIsHiddenForTest() -> Bool {
        return messageLabel.isHidden
    }
    
    
}
