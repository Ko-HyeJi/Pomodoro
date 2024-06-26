//
//  NotificationService.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/3/24.
//

import NotificationCenter
import SwiftUI

final class NotificationService {
  static let shared = NotificationService()
  
  private let center = UNUserNotificationCenter.current()
  
  func requestAuthorization() {
    self.center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
      // Error handling
    }
  }
  
  func setNotification(after timerInterval: Int) {
    let content = UNMutableNotificationContent()
    content.title = "Pomodoro".localized()
    content.body = "Your timer has ended.".localized()
    content.sound = UNNotificationSound.default
    
    let endDate = Date().addingTimeInterval(Double(timerInterval))
    let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: endDate)
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
    
    let request = UNNotificationRequest(identifier: "timerEnd", content: content, trigger: trigger)
    center.add(request, withCompletionHandler: nil)
  }
  
  func cancelNotification() {
    center.removePendingNotificationRequests(withIdentifiers: ["timerEnd"])
  }
}

extension String {
  func localized(comment: String = "") -> String {
    return NSLocalizedString(self, comment: comment)
  }
}
