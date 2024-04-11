//
//  TextTimerView.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import SwiftUI

struct TextTimerView: View {
  @EnvironmentObject private var timer: TimerService
  @StateObject private var viewModel = TextTimerViewModel()
  @FocusState var focusedField: UUID?
  
  var body: some View {
    ZStack(alignment: .center) {
      HStack {
        Text(viewModel.minutes)
        Text(":")
          .padding(.bottom, 5)
        Text(viewModel.seconds)
      }
      .monospacedDigit()
      .tracking(1.5)
      .foregroundStyle((focusedField != nil) ? .accent : .text)
      .font(.largeTitle.bold())
      
      TextField("", text: $viewModel.textField)
        .frame(width: 150, height: 50)
        .accentColor(.clear)
        .foregroundStyle(.clear)
        .keyboardType(.numberPad)
        .disabled(timer.state == .running)
        .focused($focusedField, equals: viewModel.textFieldUUID)
    }
    .onChange(of: timer.counter) { _, newValue in
      viewModel.updateTime(newValue)
    }
    .onChange(of: viewModel.textField) { _, newValue in
      if focusedField != nil { viewModel.updateText(newValue) }
      if newValue.count == 4 { focusedField = nil }
    }
    .onChange(of: focusedField) {
      withAnimation { viewModel.setTimer() }
    }
  }
}

#Preview {
  TextTimerView()
    .environmentObject(TimerService())
}
