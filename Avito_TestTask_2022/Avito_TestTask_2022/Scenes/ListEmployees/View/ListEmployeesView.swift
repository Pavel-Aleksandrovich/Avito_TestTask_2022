//
//  ListEmployeesView.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 14.11.2022.
//

import UIKit

final class ListEmployeesView: UIView {
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    var tableViewDataSource: UITableViewDataSource? {
        get {
            nil
        }
        set {
            tableView.dataSource = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListEmployeesView {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
}

// MARK: - Config Appearance
private extension ListEmployeesView {
    
    func configAppearance() {
        backgroundColor = .white
        
        tableView.backgroundColor = .clear
        tableView.register(ListEmployeesTableCell.self,
                           forCellReuseIdentifier: ListEmployeesTableCell.id)
    }
}

// MARK: - Make Constraints
private extension ListEmployeesView {
    
    func makeConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
