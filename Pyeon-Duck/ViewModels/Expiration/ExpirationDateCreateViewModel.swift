//
//  ExpirationDateCreateViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/29/23.
//

import Foundation

class ExpirationDateCreateViewModel {
    var dataManager = DataManager()
    var expirationItem: ExpirationDate?
    var selectedTagNum = 1 // 1: Read 2: Update
    var sstService = SSTService.shared
}

extension ExpirationDateCreateViewModel {
    func addExpiration(_ title: String, _ date: String, _ image: Data, _ creationDate: String, isConfirm: Bool) {
        self.dataManager.addExpiration(title, date, image, creationDate, isConfirm: isConfirm)
    }

    func updateExpiration(_ expiration: ExpirationDate, newTitle: String, newDate: String, newModifiedDate: String) {
        self.dataManager.updateExpiration(expiration, newTitle: newTitle, newDate: newDate, newModifiedDate: newModifiedDate)
    }
}

extension ExpirationDateCreateViewModel {
    func dateToStrFormatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"

        let dateString = formatter.string(from: date)
        return dateString
    }
}
