//
//  ExpirationCalendarViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 1/1/24.
//

import Foundation

class ExpirationCalendarViewModel {
    var selectedDate: DateComponents?
    var date: String?
    private var dataManager = DataManager()

    var expirationList: [ExpirationDate] {
        return self.dataManager.expirationList.filter { $0.date == self.date }
    }
}

extension ExpirationCalendarViewModel {
    func fetchExpirationList() {
        self.dataManager.requestExpiration()
    }

    func strToDateFormatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"

        let dateString = formatter.string(from: date)
        return dateString
    }
}
