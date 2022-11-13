//
//  ListEmployeesAssembly.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import UIKit

final class ListEmployeesAssembly {
    
    static func build() -> UIViewController {
        let network = NetworkServices()
        let userDefaults = UserDefaultsWrapper()
        let dataParser = DataParser()
        let interactor = ListEmployeesInteractor(network: network,
                                                 userDefaults: userDefaults,
                                                 dataParser: dataParser)
        let presenter = ListEmployeesPresenter(interactor: interactor)
        let controller = ListEmployeesViewController(presenter: presenter)
        
        return controller
    }
}
