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

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
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
    let frameCount = 2

    var entry: Provider.Entry
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.green
                ForEach(0 ... frameCount - 1, id: \.self) { index in
                    Image("\(index)")
                        .resizable()
                        .scaledToFit()
                        .mask(alignment: .center) {
                            ZStack {
                                Text("\(entry.date + TimeInterval(index), style: .timer)")
                                    .multilineTextAlignment(.center)
                                    .font(.custom("DynamicFrame2Empty", size: 50))
                                    .opacity(1.0)
                                    .scaleEffect(3)
                            }
                        }
                }
                .overlay(
                    VStack(content: {
                        Spacer()
                        Text(entry.date, style: .time)
                            .foregroundColor(.blue)
                    })
                )
            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
        }

//            ZStack {
//                Text(Image("2"))  + Text(Date(), style: .timer)
//            }
//            ZStack {
//                Text(Image("3"))  + Text(Date(), style: .timer)
//            }
//        }
    }
}

struct TestWidget: Widget {
    let kind: String = "TestWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            TestWidgetEntryView(entry: entry)
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
