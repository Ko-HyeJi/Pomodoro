//
//  TextTimerViewModel.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import Foundation

final class TextTimerViewModel {
  private let timer = TimerService.shared
  private var minutes: String { formatter(timer.counter / 60) }
  private var seconds: String { formatter(timer.counter % 60) }
  var time: String { "\(minutes):\(seconds)" }
  
  func getTime() -> String{
    return time
  }
  
  private func formatter(_ num: Int) -> String {
    return String(format: "%02d", num)
  }
}
