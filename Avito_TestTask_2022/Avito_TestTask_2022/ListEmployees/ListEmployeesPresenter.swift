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
    private let network: INetworkServices
    private var companyArray: [CompanyDTO] = []
    
    var numberOfRowsInSection: Int {
        companyArray.first?.employees.count ?? 0
    }
    
    init(network: INetworkServices) {
        self.network = network
    }
}

extension ListEmployeesPresenter: IListEmployeesPresenter {
    
    func onViewAttached(controller: IListEmployeesViewController) {
        self.controller = controller
        
        network.loadListEmployees { result in
            switch result {
            case .success(let array):
                DispatchQueue.main.async {
                    self.companyArray = [array.company]
                    self.controller?.reloadData()
                    print(array)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
 
