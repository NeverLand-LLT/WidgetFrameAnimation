//
//  ContentView.swift
//  Mirco_WidgetLab
//
//  Created by Liangyz on 2023/8/5.
//

import ClockHandRotationKit
import SwiftUI

struct Rectangle1: View {
    var offset: CGFloat = 60
    var scale: CGFloat = 1
    var size: CGSize = CGSize(width: 30, height: 30)
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .frame(width: size.width, height: size.height)
                .clockHandRotationEffect(period: .custom(-scale * 2.0), in: .current, anchor: .center)
                .offset(x: offset)
        }
        .clockHandRotationEffect(period: .custom(scale), in: .current, anchor: .center)
    }
}

struct TestView: View {
    let size: CGSize = CGSize(width: 30, height: 30)
    @State var offsetX: CGFloat = 60
    @State var scale: CGFloat = 15
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 240, height: 1)
                .foregroundColor(.red.opacity(1))

            Color.orange
                .frame(width: 240, height: 120)
                .overlay {
                    ZStack {
                        Rectangle1(offset: offsetX, scale: scale, size: size)
                            .foregroundColor(.blue.opacity(1))
                            .offset(x: 60)
                    }
                    .clockHandRotationEffect(period: .custom(-scale * 2.0), in: .current, anchor: .center)
                }
                .clipped()

            VStack {
                Spacer()
                Slider(value: $offsetX, in: -120 ... 240, step: 30) {
                    Text("OffsetX")
                } onEditingChanged: { _ in
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
                Slider(value: $scale, in: 0 ... 4, step: 0.001) {
                    Text("Scale")
                } onEditingChanged: { _ in
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        TestView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
