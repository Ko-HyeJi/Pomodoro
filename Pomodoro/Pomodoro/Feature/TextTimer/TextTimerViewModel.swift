//
//  TextTimerViewModel.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import Foundation

final class TextTimerViewModel: ObservableObject {
//  let timer = TimerService.shared
  @Published var minutes: String = "00"
  @Published var seconds: String = "00"
  
  func formatter(_ num: Int) -> String {
    return String(format: "%02d", num)
  }
}
