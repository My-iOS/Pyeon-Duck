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
    ////  Date -> String
    ////  -  Date : Input Date Value
    ////  - Return : Formatted String Date value
    func dateToStrFormatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"

        let dateString = formatter.string(from: date)
        return dateString
    }

    ////  String -> Date
    ////  -  Date : String Date in Core Data
    ////  - Return : Formatted Date value
    func strToDate(_ date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR") // 일반적으로 설정하는 로케일
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul") // 서울 시간대 설정
        return dateFormatter.date(from: date) ?? Date.now
    }
}
