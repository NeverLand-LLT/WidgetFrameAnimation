//
//  FrameAnimationView.swift
//  Mirco_WidgetLab
//
//  Created by GA-清理(Melody) on 2023/8/22.
//

import Intents
import SwiftUI
import WidgetKit

struct FrameAnimationView: View {
    let frameImages = ["0", "1", "2", "3"]

    var entry: Provider.Entry
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color.green
                ForEach(frameImages.indices, id: \.self) { index in
                    let imageDate = Date(timeInterval: TimeInterval(index), since: entry.date)
                    Image("\(index)")
                        .resizable()
                        .scaledToFit()
                        .mask(alignment: .center) {
                            Text(imageDate, style: .timer)
                                .multilineTextAlignment(.center)
                                .font(.custom("TreeNewBee\(frameImages.count)", size: 40))
                                .scaleEffect(3)
                                .offset(x: -40)
                        }
                }

                
//                Text(entry.date, style: .timer)
//                    .font(.custom("TreeNewBee\(frameImages.count)", size: 20))
////                    .font(.system(.body))
//                    .multilineTextAlignment(.center)
//                    .foregroundColor(.blue)
            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
        }
    }
}

struct DigitalFrameAnimationView: View {
    let frameImages = ["0", "1", "2", "3"]

    var entry: Provider.Entry
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color.green
                ForEach(frameImages.indices, id: \.self) { index in
                    let imageDate = Date(timeInterval: TimeInterval(index), since: entry.date)
                    Text("\(index)")
                        .font(.system(.largeTitle))
                        .background(Color.white)
                        .frame(width: 100, height: 200)
                        .mask {
                            Text(imageDate, style: .timer)
                                .multilineTextAlignment(.center)
                                .font(.custom("DynamicFrame\(frameImages.count)", size: 50))
                                .opacity(1.0)
                        }
                }

                Text(entry.date, style: .time)
                    .font(.system(.body))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.blue)
            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
        }
    }
}
