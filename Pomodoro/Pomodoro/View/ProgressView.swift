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
  var data: [ProgressItem]
  
  var body: some View {
    Chart(data, id: \.id) { element in
      SectorMark(angle: .value("Usage", element.count))
        .foregroundStyle(element.color)
    }
  }
}

//#Preview {
//  ProgressView(data: [ProgressItem(count: 3000, color: .accentColor), ProgressItem(count: 600, color: .clear)])
//}
