//
//  InternetChecker.swift
//  Avito_TestTask_2022
//
//  Created by pavel mishanin on 12.11.2022.
//

import Foundation
import Network

protocol IInternetChecker {
    func setInternetStatusListener(completion: ((Bool) -> ())?)
}

final class InternetChecker {
    
    private let pathMonitor = NWPathMonitor()
    
    private var networkAvailableHandler: ((Bool) -> ())? = nil
    
    let queue = DispatchQueue(label: "monitor")
    
    init() {
        self.getPathStatus()
        self.pathMonitor.start(queue: queue)
    }
}

extension InternetChecker: IInternetChecker {
    
    func setInternetStatusListener(completion: ((Bool) -> ())? = nil) {
        self.networkAvailableHandler = completion
        
        let status = self.getInternetStatus()
        completion?(status)
    }
}

private extension InternetChecker {
    
    func getPathStatus() {
        self.pathMonitor.pathUpdateHandler = { path in
            
            let status = path.status == .satisfied
            self.networkAvailableHandler?(!status)
        }
    }
    
    func cancelInternetStatusListener() {
        self.pathMonitor.cancel()
    }
    
    func getInternetStatus() -> Bool {
        return self.pathMonitor.currentPath.status == .satisfied
    }
}
