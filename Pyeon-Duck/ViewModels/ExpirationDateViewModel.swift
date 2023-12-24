//
//  ExpirationDateViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import Foundation

class ExpirationDateViewModel {
    private var dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

// MARK: - CRUD

extension ExpirationDateViewModel {
    var requestExpirationCount: Int {
        self.dataManager.expirationList.count
    }

    func fetchExpirationList() {
        self.dataManager.requestExpiration()
    }

    func addExpiration(_ expiration: String) {
        print("##### \(expiration)")
        self.dataManager.addExpiration(expiration)
    }
}
