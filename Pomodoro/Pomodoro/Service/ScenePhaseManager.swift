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
  private var saveDate: Date?
  private var saveTime: Int?
  
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
      saveDate = Date()
      saveTime = timer.counter
      notification.setTimerEndNotification(after: timer.counter)
    }
  }

  private func active() {
    withAnimation {
      if let saveDate = saveDate, let saveTime = saveTime {
        timer.set(to: saveTime - Int(Date().timeIntervalSince(saveDate)))
      }
    }
  }
}
