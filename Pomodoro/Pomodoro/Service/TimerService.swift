//
//  TimerService.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import Foundation
import Combine
import AVFoundation

final class TimerService: ObservableObject {
  static let shared = TimerService()
  
  @Published var state: TimerState = .stopped
  @Published private(set) var counter = 0
  private var subscription: AnyCancellable?
  var latestSetTime = 0
  
  private func cancelSubscription() {
    self.subscription?.cancel()
  }
  
  func set(to count: Int) {
    if count < 0 {
      self.stop()
      self.counter = 0
    } else {
      self.counter = count
    }
  }
  
  func start() {
    subscription = Timer.publish(every: 1.0, on: .main, in: .common)
      .autoconnect()
      .sink { [weak self] _ in
        guard let self = self else { return }
        if self.counter > 0 {
          self.counter -= 1
        } else {
          self.stop()
          playSystemSound()
        }
      }
    self.state = .running
  }
  
  func pause() {
    self.cancelSubscription()
    self.state = .paused
  }
  
  func stop() {
    self.cancelSubscription()
    self.subscription = nil
    self.state = .stopped
  }
  
  func playSystemSound() {
    AudioServicesPlaySystemSound(1005)
  }
  
  enum TimerState {
    case running
    case paused
    case stopped
  }
}
