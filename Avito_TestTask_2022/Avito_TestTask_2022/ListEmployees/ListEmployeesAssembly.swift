//
//  ListEmployeesAssembly.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import UIKit

final class ListEmployeesAssembly {
    
    static func build() -> UIViewController {
        let presenter = ListEmployeesPresenter()
        let controller = ListEmployeesViewController(presenter: presenter)
        
        return controller
    }
}
