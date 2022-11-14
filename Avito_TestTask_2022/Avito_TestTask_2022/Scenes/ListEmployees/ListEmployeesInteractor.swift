//
//  ListEmployeesInteractor.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import Foundation

protocol IListEmployeesInteractor: AnyObject {
    func loadData(completion: @escaping (Result<DTO, Error>) -> ())
    func setInternetStatusListener(completion: @escaping ((Bool) -> ()))
}

final class ListEmployeesInteractor {
    
    private let network: INetworkServices
    private let internetChecker: IInternetChecker
    private let userDefaults: IUserDefaultsWrapper
    private let dataParser: IDataParser
    
    init(network: INetworkServices,
         internetChecker: IInternetChecker,
         userDefaults: IUserDefaultsWrapper,
         dataParser: IDataParser) {
        self.network = network
        self.internetChecker = internetChecker
        self.userDefaults = userDefaults
        self.dataParser = dataParser
    }
}

extension ListEmployeesInteractor: IListEmployeesInteractor {
    
    func loadData(completion: @escaping (Result<DTO, Error>) -> ()) {
        switch userDefaults.isSaved(forKey: .company) {
        case true:
            loadFromCache(completion: completion)
        case false:
            loadFromNetwork(completion: completion)
        }
    }
    
    func setInternetStatusListener(completion: @escaping ((Bool) -> ())) {
        internetChecker.setInternetStatusListener(completion: completion)
    }
}

private extension ListEmployeesInteractor {
    
    func loadFromCache(completion: @escaping (Result<DTO, Error>) -> ()) {
        let date = userDefaults.object(forKey: .currentDate) as? Date ?? Date()
        
        switch Date().timeIntervalSince(date) > 3600 {
        case true:
            userDefaults.removeObject(forKey: .company)
            loadFromNetwork(completion: completion)
        case false:
            dataParser.decode(data: userDefaults.data(forKey: .company),
                              completion: completion)
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
