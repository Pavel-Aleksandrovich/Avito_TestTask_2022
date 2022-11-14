//
//  DataParser.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 13.11.2022.
//

import Foundation

protocol IDataParser: AnyObject {
    func decode(data: Data?, completion: @escaping (Result<DTO, Error>) -> ())
}

final class DataParser {}

extension DataParser: IDataParser {
    
    func decode(data: Data?, completion: @escaping (Result<DTO, Error>) -> ()) {
        do {
            let newData = try JSONDecoder().decode(DTO.self, from: data ?? Data())
            completion(.success(newData))
        }
        catch {
            completion(.failure(error))
        }
    }
}
