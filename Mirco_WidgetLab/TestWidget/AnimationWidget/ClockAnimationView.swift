//
//  ClockAnimationView.swift
//  Mirco_WidgetLab
//
//  Created by GA-清理(Melody) on 2023/8/22.
//

import ClockHandRotationKit
import Intents
import SwiftUI
import WidgetKit

struct ClockAnimationView: View {
    var entry: Provider.Entry
    let size: CGFloat = 45

    @State var interval: CGFloat = 5
    var body: some View {
        GeometryReader { proxy in
            let offset: CGFloat = (proxy.size.width - size) / 2.0 - size * 0.5
            Color.orange
                .frame(width: proxy.size.width, height: proxy.size.height)
                .overlay {
                    ScrollAnimation(offset: offset, interval: interval, size: size)
                        .foregroundColor(.blue.opacity(1))
                        .offset(x: 0, y: 0)
                        .clockHandRotationEffect(period: .custom(interval), in: .current, anchor: .center)
                        .offset(x: CGFloat(offset), y: 0)
                        .clockHandRotationEffect(period: .custom(-interval), in: .current, anchor: .center)
                }
        }
    }
}

struct ScrollAnimation: View {
    var offset: CGFloat
    var interval: CGFloat
    var size: CGFloat
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(.blue)
                .frame(width: size, height: size)
                .offset(x: 0, y: 0)
                .clockHandRotationEffect(period: .custom(-interval), in: .current, anchor: .center)
                .offset(x: offset)
                .clockHandRotationEffect(period: .custom(interval), in: .current, anchor: .center)
        }
    }
}
