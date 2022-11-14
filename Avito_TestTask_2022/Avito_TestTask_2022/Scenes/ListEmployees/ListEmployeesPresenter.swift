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
    func getModelByIndex(_ index: Int) -> ListEmployeesViewModel
}

final class ListEmployeesPresenter {
    
    private weak var controller: IListEmployeesViewController?
    private let interactor: IListEmployeesInteractor
    private var employeesArray: [ListEmployeesViewModel] = []
    
    init(interactor: IListEmployeesInteractor) {
        self.interactor = interactor
    }
}

extension ListEmployeesPresenter: IListEmployeesPresenter {
    
    var numberOfRowsInSection: Int {
        employeesArray.count
    }
    
    func onViewAttached(controller: IListEmployeesViewController) {
        self.controller = controller
        
        controller.loadingState(.start)
        setInternetStatusListener()
    }
    
    func getModelByIndex(_ index: Int) -> ListEmployeesViewModel {
        employeesArray[index]
    }
}

private extension ListEmployeesPresenter {
    
    func loadData() {
        interactor.loadData { result in
            switch result {
            case .success(let dto):
                self.employeesArray = self.viewModelFrom(dto)
                self.sortByName()
                self.controller?.loadingState(.stop)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.controller?.loadingState(.error(error.localizedDescription))
                }
            }
        }
    }
    
    func sortByName() {
        employeesArray.sort { $0.employeeName < $1.employeeName }
    }
    
    func viewModelFrom(_ dto: DTO) -> [ListEmployeesViewModel] {
        dto.company.employees.map { ListEmployeesViewModel(model: $0,
                                                           companyName: dto.company.name)}
    }
    
    func setInternetStatusListener() {
        interactor.setInternetStatusListener { bool in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.loadData()
            })
        }
    }
}
