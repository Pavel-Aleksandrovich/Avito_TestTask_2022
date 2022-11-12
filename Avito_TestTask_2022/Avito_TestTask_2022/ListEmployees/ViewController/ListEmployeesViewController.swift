//
//  ListEmployeesViewController.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import UIKit

protocol IListEmployeesViewController: AnyObject {
    
}

final class ListEmployeesViewController: UIViewController {

    private let presenter: IListEmployeesPresenter
    
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
        view.backgroundColor = .red
    }
}

extension ListEmployeesViewController: IListEmployeesViewController {
    
}
