//
//  ProgressView.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/7/24.
//

import SwiftUI
import Charts

struct ProgressItem {
  let id = UUID()
  var count: Int
  let color: Color
}

struct ProgressView: View {
  @EnvironmentObject var timer: TimerService

  var body: some View {
    Chart([ProgressItem(count: timer.counter, color: .accentColor), ProgressItem(count: 3_600 - timer.counter, color: .clear)], id: \.id) { element in
      SectorMark(angle: .value("count", element.count))
        .foregroundStyle(element.color)
    }
  }
}
