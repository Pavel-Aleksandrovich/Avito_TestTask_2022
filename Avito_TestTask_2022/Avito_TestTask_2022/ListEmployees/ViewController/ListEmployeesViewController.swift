//
//  ListEmployeesViewController.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import UIKit

protocol IListEmployeesViewController: AnyObject {
    func reloadData()
    func showAlert(title: String)
}

final class ListEmployeesViewController: UIViewController {

    private let presenter: IListEmployeesPresenter
    private let tableView = UITableView()
    
    init(presenter: IListEmployeesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(controller: self)
        view.backgroundColor = .white
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListEmployeesTableCell.self,
                           forCellReuseIdentifier: ListEmployeesTableCell.id)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

extension ListEmployeesViewController: IListEmployeesViewController {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let label = UILabel()
        label.text = "Change to \(title)"
        let randomAction = UIAlertAction(title: label.text,
                                         style: .destructive) {_ in
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(randomAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension ListEmployeesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListEmployeesTableCell.id,
            for: indexPath) as? ListEmployeesTableCell
        else { return UITableViewCell() }
        
        
        cell.setData(index: indexPath.row)
        print()
        return cell
    }
}
