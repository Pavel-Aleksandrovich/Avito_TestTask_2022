//
//  ListEmployeesViewModel.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 14.11.2022.
//

import Foundation

struct ListEmployeesViewModel {
    let companyName: String
    let employeeName: String
    let phoneNumber: String
    let skills: String
    
    init(model: EmployeeDTO, companyName: String) {
        self.companyName = companyName
        self.employeeName = model.name
        self.phoneNumber = model.phoneNumber
        self.skills = model.skills.joined(separator: ", ")
    }
}
