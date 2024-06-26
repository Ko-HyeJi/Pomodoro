//
//  ControlButtonView.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import SwiftUI

struct ControlButtonView: View {
  private var viewModel = ControlButtonViewModel()
  private let radiusSize = 25.0
  private let buttonHeight = 60.0
  
  var body: some View {
    Button {
      action { viewModel.buttonAction }
    } label: {
      switch viewModel.state {
      case .play:
        RoundedRectangle(cornerRadius: radiusSize)
          .outerShadow()
//          .softOuterShadow(
//            darkShadow: .darkShadow,
//            lightShadow: .lightShadow
//          )
      case .pause:
        RoundedRectangle(cornerRadius: radiusSize)
          .softInnerShadow(
            RoundedRectangle(cornerRadius: radiusSize),
            darkShadow: .darkShadow,
            lightShadow: .lightShadow
          )
      }
    }
    .frame(height: buttonHeight)
    .foregroundStyle(Color.main)
    .overlay(image(viewModel.imageName))
    .disabled(viewModel.isButtonDisabled)
  }
}

extension ControlButtonView {
  private func image(_ imageName: String) -> some View {
    Image(systemName: imageName)
      .dynamicTypeSize(.xxxLarge)
      .foregroundStyle(Color.text)
  }
  
  private func action(_ action: () -> ()) {
    let haptic = UISelectionFeedbackGenerator()
    return withAnimation(.easeIn(duration: 0.2)) {
      action()
      haptic.selectionChanged()
    }
  }
}

#Preview {
  ControlButtonView()
    .environmentObject(TimerService())
}
