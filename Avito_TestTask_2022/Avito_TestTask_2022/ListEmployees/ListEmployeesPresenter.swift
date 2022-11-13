//
//  ListEmployeesPresenter.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import Foundation

protocol IListEmployeesPresenter: AnyObject {
    var numberOfRowsInSection: Int { get }
    func onViewAttached(controller: IListEmployeesViewController)
}

final class ListEmployeesPresenter {
    
    private weak var controller: IListEmployeesViewController?
    private let interactor: IListEmployeesInteractor
    private var companyArray: [DTO] = []
    
    var numberOfRowsInSection: Int {
        companyArray.first?.company.employees.count ?? 0
    }
    
    init(interactor: IListEmployeesInteractor) {
        self.interactor = interactor
    }
}

extension ListEmployeesPresenter: IListEmployeesPresenter {
    
    func onViewAttached(controller: IListEmployeesViewController) {
        self.controller = controller
        
        loadData()
        
        interactor.setInternetStatusListener { bool in
            if bool {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    self.loadData()
                })
            }
        }
    }
}
 
private extension ListEmployeesPresenter {
    
    func loadData() {
        interactor.loadData { result in
            switch result {
            case .success(let array):
//                DispatchQueue.main.async {
                    self.companyArray = [array]
                    self.controller?.reloadData()
//                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
