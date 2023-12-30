//
//  ExpirationDateViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import Foundation

class ExpirationListViewModel {
    private var dataManager: DataManager
    var selectedDate: String?

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

// MARK: - CRUD

extension ExpirationListViewModel {
    var requestExpirationCount: Int {
        self.dataManager.expirationList.count
    }

    var expirationList: [ExpirationDate] {
        return self.dataManager.expirationList.filter { $0.date == self.selectedDate ?? dateToStrFormatted(Date.now) }
    }

    func fetchExpirationList() {
        self.dataManager.requestExpiration()
    }

    func addExpiration(_ expiration: ExpirationDate) {
        print("##### \(expiration)")
//        self.dataManager.addExpiration(expiration)
    }

    func deleteExpiration(at indexPath: IndexPath) {
        self.dataManager.deleteExpiration(at: indexPath)
    }

    func updateCompletedStatus(_ expiration: ExpirationDate, isConfirm: Bool) {
        self.dataManager.updateConfirm(expiration, isConfirm: isConfirm)
    }
}

extension ExpirationListViewModel {
    func dateToStrFormatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"

        let dateString = formatter.string(from: date)
        return dateString
    }
}
