//
//  ButtonViewModel.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/23/24.
//

import Foundation
import SwiftUI

final class ButtonViewModel {
  private var timer = TimerService.shared
  var state: ButtonState { timer.state != .running ? .play : .pause }
  var isButtonDisabled: Bool { timer.counter == 0 }
  
  var imageName: String {
    switch state {
    case .play:
      "play.fill"
    case .pause:
      "pause.fill"
    }
  }

  var buttonAction: () {
    switch state {
    case .play:
      TimerService.shared.start()
    case .pause:
      TimerService.shared.pause()
    }
  }
  
  enum ButtonState {
    case play
    case pause
  }
}
