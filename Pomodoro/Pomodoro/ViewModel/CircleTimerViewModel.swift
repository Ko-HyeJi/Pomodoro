//
//  CircleTimerViewModel.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/23/24.
//

import Foundation
import SwiftUI

final class CircleTimerViewModel {
  private let haptic = UISelectionFeedbackGenerator()
  private let timer = TimerService.shared
  
  func saveTimeAndGenerateHaptic() {
    if timer.state != .running {
      haptic.selectionChanged()
      if timer.counter != 0 {
        timer.latestSetTime = timer.counter
      }
    }
  }
  
  func centerCircleAction() {
    if timer.state != .running {
      withAnimation {
        if timer.counter == 0 {
          timer.set(to: timer.latestSetTime)
        } else {
          timer.set(to: 0)
        }
      }
    }
  }
}
