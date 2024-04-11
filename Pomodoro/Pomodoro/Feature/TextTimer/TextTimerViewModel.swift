//
//  TextTimerViewModel.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import Foundation

final class TextTimerViewModel: ObservableObject {
  @Published var minutes: String
  @Published var seconds: String
  @Published var textField: String
  @Published var textFieldUUID: UUID
  let timer: TimerService
  
  init(
    timer: TimerService = TimerService.shared,
    minutes: String = "00",
    seconds: String = "00",
    textField: String = "",
    textFieldUUID: UUID = UUID()
  ) {
    self.timer = timer
    self.minutes = minutes
    self.seconds = seconds
    self.textField = textField
    self.textFieldUUID = textFieldUUID
  }
}

extension TextTimerViewModel {
  func updateTime(_ newValue: Int) {
    minutes = newValue.minutes()
    seconds = newValue.seconds()
  }
  
  func updateText(_ newValue: String) {
    switch newValue.count {
    case 0:
      minutes = "00"
      seconds = "00"
    case 1:
      minutes = "00"
      seconds = "0" + newValue
    case 2:
      minutes = "00"
      seconds = newValue
    case 3:
      minutes = "0" + newValue.prefix(1)
      seconds = String(newValue.suffix(2))
    default:
      minutes = String(newValue.prefix(2))
      seconds = String(newValue.suffix(2))
    }
  }
  
  func setTimer() {
    if minutes > "60" {
      minutes = "60"
    }
    if seconds > "60" {
      seconds = "60"
    }
    if minutes == "60" && seconds > "00" {
      seconds = "00"
    }
    timer.set(to: Int(minutes)! * 60 + Int(seconds)!)
    textField = ""
  }
}
