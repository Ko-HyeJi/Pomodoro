//
//  TextTimerView.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import SwiftUI

struct TextTimerView: View {
  @EnvironmentObject var timer: TimerService
  @StateObject private var viewModel = TextTimerViewModel()
  
  var body: some View {
    Text(viewModel.time)
      .monospacedDigit()
      .tracking(1.5)
      .foregroundStyle(Color.text)
      .font(.largeTitle.bold())
  }
}

#Preview {
  TextTimerView()
    .environmentObject(TimerService())
}
