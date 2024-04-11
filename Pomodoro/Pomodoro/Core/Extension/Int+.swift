//
//  Int+.swift
//  Pomodoro
//
//  Created by 고혜지 on 4/11/24.
//

import Foundation

extension Int {
  func minutes() -> String {
    return String(format: "%02d", self / 60)
  }

  func seconds() -> String {
    return String(format: "%02d", self % 60)
  }
}
