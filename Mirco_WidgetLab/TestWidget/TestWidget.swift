//
//  TestWidget.swift
//  TestWidget
//
//  Created by Liangyz on 2023/8/5.
//

import Intents
import SwiftUI
import WidgetKit

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 50 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate.zeroSeconds(), configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct TestWidgetEntryView: View {
    let frameImages = ["0", "1", "2", "3"]

    var entry: Provider.Entry
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                Color.green
                ForEach(frameImages.indices, id: \.self) { index in
                    let imageDate = Date(timeInterval: TimeInterval(index), since: entry.date)
//                    Image("\(index)")
//                        .resizable()
//                        .scaledToFit()
//                        .mask(alignment: .center) {
//                            Text(imageDate, style: .timer)
//                                .multilineTextAlignment(.center)
//                                .font(.custom("DynamicFrame\(frameImages.count)", size: 50))
//                                .opacity(1.0)
//                                .scaleEffect(3)
//                        }
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

struct TestWidget: Widget {
    let kind: String = "TestWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
//            FrameAnimationView(entry: entry) // 图片帧动画
//            DigitalFrameAnimationView(entry: entry) //  电子时钟动画
            ClockAnimationView(entry: entry) // 时钟动画
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct TestWidget_Previews: PreviewProvider {
    static var previews: some View {
        TestWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
