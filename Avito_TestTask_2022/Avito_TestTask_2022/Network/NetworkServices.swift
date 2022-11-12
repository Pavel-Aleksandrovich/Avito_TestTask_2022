//
//  NetworkServices.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import Foundation

protocol INetworkServices: AnyObject {
    func loadListEmployees(completion: @escaping (Result<DTO, Error>) -> ())
}

final class NetworkServices {
    
    private let session: URLSession
    
    private let baseApi = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    init(configuration: URLSessionConfiguration? = nil) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: .default)
        }
    }
}

extension NetworkServices: INetworkServices {
    
    func loadListEmployees(completion: @escaping (Result<DTO, Error>) -> ()) {
        loadData(api: baseApi, completion: completion)
    }
}

private extension NetworkServices {
    
    func loadData<T: Decodable>(api: String,
                                completion: @escaping (Result<T, Error>) -> ()) {
        
        guard let url = URL(string: api)
        else {
            return
        }
        
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            if let error = error { print("error")
                completion(.failure(error))
            }
            guard let data = data
            else { print("data")
                return }
            
            do {
                let newData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(newData))
            }
            catch {
                print("decode error --> \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
