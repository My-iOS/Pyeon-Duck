//
//  CalenderService.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/23/23.
//

import Foundation

class CalenderService {
    static let shared = CalenderService()

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

        // 현재 달의 첫 날과 마지막 날을 계산
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now)),
              let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)
        else {
            return 0
        }
        //    print(startOfMonth)

        // 첫 날과 마지막 날의 주 번호를 구함
        let firstWeek = calendar.component(.weekday, from: startOfMonth)
        print(firstWeek)
        let lastWeek = calendar.component(.weekday, from: endOfMonth)
        print(lastWeek)

        // 주 번호의 차이를 계산하여 해당 달의 주 수를 반환
        return firstWeek - lastWeek
    }

    // 일년동안 각 달들이 몇일 있는지 계산하는 함수
    func daysInMonths(for year: Int) -> [Int] {
        let calendar = Calendar.current
        var daysInMonths: [Int] = []

        for month in 1 ... 12 {
            let dateComponents = DateComponents(year: year, month: month)

            // 해당 월의 첫 날과 다음 달의 첫 날을 계산
            if let startDate = calendar.date(from: dateComponents),
               let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate)
            {
                // 해당 월의 일 수를 계산
                let days = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
                daysInMonths.append(days + 1) // endDate는 포함되므로 1을 더합니다.
            }
        }

        return daysInMonths
    }

    private init() {}
}
