//
//  DataParser.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 13.11.2022.
//

import Foundation

protocol IDataParserServices: AnyObject {
    func decode(data: Data, completion: @escaping (Result<DTO, Error>) -> ())
    func encode(model: [DTO], completion: @escaping (Result<Data, Error>) -> ())
}

final class DataParserServices {}

extension DataParserServices: IDataParserServices {
    
    func decode(data: Data, completion: @escaping (Result<DTO, Error>) -> ()) {
        do {
            let newData = try JSONDecoder().decode(DTO.self, from: data)
            completion(.success(newData))
        }
        catch {
            completion(.failure(error))
        }
    }
    
    func encode(model: [DTO], completion: @escaping (Result<Data, Error>) -> ()) {
        do {
            let encodedData = try JSONEncoder().encode(model)
            completion(.success(encodedData))
        }
        catch {
            completion(.failure(error))
        }
    }
}
