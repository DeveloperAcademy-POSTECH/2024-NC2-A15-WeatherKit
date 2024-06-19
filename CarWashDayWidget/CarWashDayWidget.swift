//
//  CarWashDayWidget.swift
//  CarWashDayWidget
//
//  Created by Seol WooHyeok on 6/19/24.
//

import WidgetKit
import SwiftUI
import CoreLocation
import WeatherKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), humidity: 9.99) // placeholder humidity
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), humidity: 9.99) // placeholder humidity
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let nextUpdate = Date().addingTimeInterval(3600) // 1 hour in seconds
                        
            let sampleLocation = CLLocation(latitude: 51.5072, longitude: 0.1276) // sample location (London)
            let weather = try await WeatherService.shared.weather(for: sampleLocation)
            let entry = SimpleEntry(date: .now, humidity: weather.currentWeather.humidity)
            
            let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let humidity: Double
}



struct CarWashDayWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("\(entry.humidity)")
                .foregroundStyle(.black)
        }
        .widgetBackground(.white)
    }
}

struct CarWashDayWidget: Widget {
    let kind: String = "WidgetWeatherTest"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            CarWashDayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Widget Weather Test")
        .description("Testing weatherkit in a Widget")
        .supportedFamilies([.systemMedium])
    }
}

extension View {
    func widgetBackground(_ color: Color) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                color
            }
        } else {
            return background(color)
        }
    }
}
