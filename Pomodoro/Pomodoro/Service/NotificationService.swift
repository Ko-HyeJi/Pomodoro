//
//  NotificationService.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/3/24.
//

import NotificationCenter

class NotificationService {
  static let shared = NotificationService()
  
  private let center = UNUserNotificationCenter.current()
  
  func requestAuthorization() {
    self.center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
      // Error handling
    }
  }
  
  func setTimerEndNotification(after timerInterval: Int) {
    let content = UNMutableNotificationContent()
    content.title = "Pomodoro"
    content.body = "Your timer has ended."
    content.sound = UNNotificationSound.default

    let endDate = Date().addingTimeInterval(Double(timerInterval))
    let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: endDate)

    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

    let request = UNNotificationRequest(identifier: "timerEnd", content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
  }
}
