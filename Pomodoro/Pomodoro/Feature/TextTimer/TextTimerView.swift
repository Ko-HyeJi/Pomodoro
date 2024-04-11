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
  @State private var textField = ""
  @State var textFieldUUID = UUID()
  
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
      
      TextField("", text: $textField)
        .frame(width: 150, height: 50)
        .accentColor(.clear)
        .foregroundStyle(.clear)
        .keyboardType(.numberPad)
        .disabled(timer.state == .running)
        .focused($focusedField, equals: textFieldUUID)
    }
    .onChange(of: timer.counter) { _, newValue in
      viewModel.minutes = viewModel.formatter(newValue / 60)
      viewModel.seconds = viewModel.formatter(newValue % 60)
    }
    .onChange(of: textField) { oldValue, newValue in
      switch newValue.count {
      case 0:
        if !(oldValue.count == 4) {
          viewModel.minutes = "00"
          viewModel.seconds = "00"
        }
      case 1:
        viewModel.minutes = "00"
        viewModel.seconds = "0" + newValue
      case 2:
        viewModel.minutes = "00"
        viewModel.seconds = newValue
      case 3:
        viewModel.minutes = "0" + newValue.prefix(1)
        viewModel.seconds = String(newValue.suffix(2))
      default:
        viewModel.minutes = String(newValue.prefix(2))
        viewModel.seconds = String(newValue.suffix(2))
        focusedField = nil
      }
    }
    .onChange(of: focusedField) {
      if viewModel.minutes > "60" {
        viewModel.minutes = "60"
      }
      if viewModel.seconds > "60" {
        viewModel.seconds = "60"
      }
      if viewModel.minutes == "60" && viewModel.seconds > "00" {
        viewModel.seconds = "00"
      }
      textField = ""
      withAnimation {
        timer.set(to: Int(viewModel.minutes)! * 60 + Int(viewModel.seconds)!)
      }
    }
  }
}

#Preview {
  TextTimerView()
    .environmentObject(TimerService())
}
