//
//  ExpirationCalendarViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 1/1/24.
//

import Foundation
import UIKit
import UserNotifications

class ExpirationCalendarViewModel {
    var selectedDate: DateComponents?
    var date: String?
    private var dataManager = DataManager()

    var expirationList: [ExpirationDate] {
        return self.dataManager.expirationList.filter { $0.date == self.date }
    }

    var todayExpirationList: [ExpirationDate] {
        return self.dataManager.expirationList.filter { $0.date == strToDateFormatted(Date.now) }
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

extension ExpirationCalendarViewModel {
    // PushNotificationHelper.swift > PushNotificationHelper
    func pushNotification(title: String, body: String, seconds: Double, identifier: String) {
        // 1. 알림 내용, 설정
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body

        // 사진 or 비디오 썸네일 추가하기
        do {
            // 1. 프로젝트에 x.jpg 추가
            // 2. imageUrl 생성 후 첨부
            //            let imageUrl = Bundle.main.url(forResource: "PyeonDuck_Icon", withExtension: "png")
            if let image = UIImage(named: "PyeonDuck_Icon") {
                // UIImage를 Data로 변환
                if let imageData = image.pngData() {
                    // 임시 URL 생성
                    let tempDirURL = FileManager.default.temporaryDirectory
                    let tempFileURL = tempDirURL.appendingPathComponent("PyeonDuck_Icon.png")

                    do {
                        // 이미지 데이터를 임시 파일로 저장
                        try imageData.write(to: tempFileURL)
                        // 임시 파일을 사용하여 알림 첨부 생성
                        let attach = try UNNotificationAttachment(identifier: "", url: tempFileURL, options: nil)
                        notificationContent.attachments.append(attach)
                    } catch {
                        print(error)
                    }
                }
            }
        }

        // 배지(Badge) 등록하기
//        let key = "AppBadgeNumber"
//        let newNumber = UserDefaults.standard.integer(forKey: key) + 1
//        UserDefaults.standard.set(newNumber, forKey: key)
//        notificationContent.badge = (newNumber) as NSNumber
//        UIApplication.shared.applicationIconBadgeNumber = 10

        // 2. 조건(시간, 반복)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)

        // 3. 요청
        let request = UNNotificationRequest(identifier: identifier, content: notificationContent, trigger: trigger)

        // 4. 알림 등록
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("#### Notification Error: \(error)")
            }
        }
    }
}

// MARK: - 하루에 어플을 처음 실행했을 때, 알림이 오게 하는 어플

extension ExpirationCalendarViewModel {
    func scheduleNotificationIfNeeded() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString = dateFormatter.string(from: Date())

        let lastNotificationDate = UserDefaults.standard.string(forKey: "lastNotificationDate")

        // 오늘 이미 알림이 스케줄링되지 않았는지 확인
        if lastNotificationDate != todayString {
            self.pushNotification(title: "유통기한 알림", body: "오늘 유통기한 마감되는 품목이 \(self.todayExpirationList.count) 개 있습니다.", seconds: 1, identifier: "ExpirationNotification")

            // 오늘 날짜를 저장
            UserDefaults.standard.set(todayString, forKey: "lastNotificationDate")
        }
    }
}
