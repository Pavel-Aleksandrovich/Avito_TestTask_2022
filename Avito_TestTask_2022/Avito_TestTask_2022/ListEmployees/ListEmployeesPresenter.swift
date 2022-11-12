//
//  ListEmployeesPresenter.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import Foundation

protocol IListEmployeesPresenter: AnyObject {
    func onViewAttached(controller: IListEmployeesViewController)
}

final class ListEmployeesPresenter {
    
    private weak var controller: IListEmployeesViewController?
}

extension ListEmployeesPresenter: IListEmployeesPresenter {
    
    func onViewAttached(controller: IListEmployeesViewController) {
        self.controller = controller
    }
}
 
