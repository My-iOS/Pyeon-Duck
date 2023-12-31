//
//  ExpirationDetailViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/29/23.
//

import Foundation

class ExpirationDetailViewModel {
    var selectedItem: ExpirationDate?
}

extension ExpirationDetailViewModel {
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
