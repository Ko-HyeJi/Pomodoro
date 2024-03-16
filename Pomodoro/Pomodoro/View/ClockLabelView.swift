//
//  ClockLabelView.swift
//  Pomodoro
//
//  Created by 고혜지 on 3/15/24.
//

import SwiftUI

struct ClockLabelView: View {
  @EnvironmentObject var timer: TimerService
  let geometry: GeometryProxy
  let device = UIDevice.current.userInterfaceIdiom
  
  var body: some View {
    ZStack {
      Color.clear
      ForEach(0..<60) { tick in
        Group {
          let length = geometry.size.width * (tick % 5 == 0 ? 0.05 : 0.02)
          Rectangle()
            .frame(width: device == .pad ? 2 : 1, height: length)
            .offset(y: (-geometry.size.width / 2) + (length / 2))
          
          if tick % 5 == 0 {
            Text("\(tick)")
              .padding(30)
              .rotationEffect(.degrees(Double(tick) * -6))
              .offset(y: -geometry.size.width * 0.57)
              .font(device == .pad ? .title2.bold() : .caption)
              .onTapGesture {
                withAnimation {
                  if timer.state != .running {
                    if tick == 0 {
                      timer.set(to: 3_600)
                    } else {
                      timer.set(to: tick * 60)
                    }
                  }
                }
              }
          }
        }
        .foregroundStyle(Color.text)
        .rotationEffect(.degrees(Double(tick) * 6))
      }
    }
  }
}

#Preview {
    GeometryReader { geometry in
      ClockLabelView(geometry: geometry)
    }
    .frame(width: UIScreen.main.bounds.width * 0.76)
}
