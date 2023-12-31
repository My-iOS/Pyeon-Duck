//
//  SalaryViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import Foundation

class SalaryViewModel {
    let calenderService = CalenderService.shared
    var weeklyWorkdayArray: [Bool] = [false, false, false, false, false, false, false] {
        didSet {
            filterWorkDayArr = weeklyWorkdayArray.enumerated()
                .filter { $0.element == true }
                .map { $0.offset + 1 }
        }
    }

    private(set) var filterWorkDayArr: [Int] = []

    // 한 달 동안 몇일을 근무하는지 계산하는 함수
    func countWeekdaysInCurrentMonth(weekday: [Int]) -> Int {
        let calendar = Calendar.current
        let now = Date()

        guard let range = calendar.range(of: .day, in: .month, for: now) else { return 0 }
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!

        var count = 0
        for day in range {
            let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)!
            let weekdayComponent = calendar.component(.weekday, from: date)
            print(weekdayComponent)
            for i in weekday {
                if weekdayComponent == i {
                    count += 1
                }
            }
        }

        return count
    }

    // 한 달 동안 몇주가 있는지 계산하는 함수
    func numberOfWeeksInCurrentMonth() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let rangeOfWeeks = calendar.range(of: .weekOfMonth, in: .month, for: now)
        return rangeOfWeeks?.count ?? 0
    }

    // 일년동안 각 달들이 몇일 있는지 계산하는 함수
    func daysInMonths(for year: Int) -> [Int] {
        let calendar = Calendar.current
        var daysInMonths: [Int] = []

        for month in 1 ... 12 {
            let dateComponents = DateComponents(year: year, month: month)

            if let startDate = calendar.date(from: dateComponents),
               let endDate = calendar.date(byAdding: DateComponents(month: 1), to: startDate)
            {
                let days = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
                daysInMonths.append(days)
            }
        }

        return daysInMonths
    }

    // 숫자 사이에 콤마 넣기
    func numberFormatted(_ inputValue: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        if let result = numberFormatter.string(from: NSNumber(value: inputValue)) {
            return result
        }
        return "0"
    }

    // 숫자 사이에 콤마 제거
    func numberFormattedStrToInt(_ inputValue: String) -> Int {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        if let result = numberFormatter.number(from: inputValue) {
            return Int(result)
        }
        return 0
    }

    // weeklyWorkdayArray 초기화
    func resetWeeklyWorkdayArray() {
        weeklyWorkdayArray = [false, false, false, false, false, false, false]
    }
}
