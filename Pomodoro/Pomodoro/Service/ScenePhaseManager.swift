//
//  ScenePhaseManager.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import SwiftUI

final class ScenePhaseManager {
  private let notification = NotificationService.shared
  private let timer = TimerService.shared
  private var savedDate: Date?
  private var savedTime: Int?
  
  // TODO: 함수명 뭘로하지?
  func action(_ scenePhase: ScenePhase) {
    switch scenePhase {
    case .background:
      self.background()
    case .active:
      self.active()
    default:
      return
    }
  }
  
  private func background() {
    if timer.state == .running {
      savedDate = Date()
      savedTime = timer.counter
      notification.setNotification(after: timer.counter)
    }
  }

  private func active() {
    if timer.state == .running {
      notification.cancelNotification()
      withAnimation {
        if let savedDate = savedDate, let savedTime = savedTime {
          timer.set(to: savedTime - Int(Date().timeIntervalSince(savedDate)))
        }
      }
    }
  }
}
