//
//  CompanyDTO.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import Foundation

struct DTO: Codable {
    let company: CompanyDTO
}

struct CompanyDTO: Codable {
    let name: String
    let employees: [EmployeeDTO]
}

struct EmployeeDTO: Codable {
    let name: String
    let phoneNumber: String
    let skills: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
