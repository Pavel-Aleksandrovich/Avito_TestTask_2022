//
//  ListEmployeesInteractor.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import Foundation

protocol IListEmployeesInteractor: AnyObject {
    func loadData(completion: @escaping (Result<DTO, Error>) -> ())
    func setInternetStatusListener(completion: ((Bool) -> ())?)
}

final class ListEmployeesInteractor {
    
    private let network: INetworkServices
    private let internetChecker = InternetChecker()
    private let userDefaults: IUserDefaultsWrapper
    private let dataParser: IDataParser
    
    init(network: INetworkServices,
         userDefaults: IUserDefaultsWrapper,
         dataParser: IDataParser) {
        self.network = network
        self.userDefaults = userDefaults
        self.dataParser = dataParser
    }
}

extension ListEmployeesInteractor: IListEmployeesInteractor {
    
    func loadData(completion: @escaping (Result<DTO, Error>) -> ()) {
        let date = userDefaults.object(forKey: .currentDate) as? Date ?? Date()
        print(date)
        print(Date())
        
        print("isSaveEmployees -> \(userDefaults.isSaved(forKey: .company))")
        // if Data saved in cache -> load frome cache, else -> load from network
        switch userDefaults.isSaved(forKey: .company) {
        case true:
            loadFromCache(completion: completion)
        case false:
            loadFromNetwork(completion: completion)
        }
    }
    
    func setInternetStatusListener(completion: ((Bool) -> ())? = nil) {
        internetChecker.setInternetStatusListener(completion: completion)
    }
}

private extension ListEmployeesInteractor {
    
    func loadFromCache(completion: @escaping (Result<DTO, Error>) -> ()) {
        let date = userDefaults.object(forKey: .currentDate) as? Date ?? Date()
        
        // if caching time is end -> load from network, else -> load from cache
        switch Date().timeIntervalSince(date) > 30 {
        case true:
            userDefaults.removeObject(forKey: .company)
            loadFromNetwork(completion: completion)
        case false:
            let data = userDefaults.object(forKey: .company) as? Data
            dataParser.decode(data: data, completion: completion)
        }
    }
    
    func loadFromNetwork(completion: @escaping (Result<DTO, Error>) -> ()) {
        network.loadData { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.userDefaults.set(value: data, forKey: .company)
                    self.userDefaults.set(value: Date(), forKey: .currentDate)
                    self.dataParser.decode(data: data, completion: completion)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
