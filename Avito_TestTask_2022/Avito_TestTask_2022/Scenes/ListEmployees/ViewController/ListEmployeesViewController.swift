//
//  ListEmployeesViewController.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import UIKit

protocol IListEmployeesViewController: AnyObject {
    func loadingState(_ state: LoadingState)
}

final class ListEmployeesViewController: UIViewController {

    private let presenter: IListEmployeesPresenter
    private let mainView = ListEmployeesView()
    
    init(presenter: IListEmployeesPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(controller: self)
        mainView.tableViewDataSource = self
    }
}

extension ListEmployeesViewController: IListEmployeesViewController {
    
    func loadingState(_ state: LoadingState) {
        switch state {
        case .start:
            mainView.startAnimating()
        case .stop:
            mainView.stopAnimating()
            mainView.reloadData()
        case .error(let errorString):
            showAlert(title: errorString)
        }
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
        
        let model = presenter.getModelByIndex(indexPath.row)
        cell.setModel(model)
        
        return cell
    }
}

private extension ListEmployeesViewController {
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
