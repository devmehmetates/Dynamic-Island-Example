//
//  DynamicIslandExampleWidget.swift
//  DynamicIslandExampleWidget
//
//  Created by Mehmet Ateş on 18.09.2022.
//

import WidgetKit
import SwiftUI

@main
struct Widgets: WidgetBundle {
    var body: some Widget {
        NavigationWidget()
    }
}

struct NavigationWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: NavigationAttributes.self) { context in
            Text("Deneme")
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    Text("ETA: " + context.state.eta.formatted())
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Heavy Traffic ahead!")
                }
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.attributes.destination).font(.caption2)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.nextTurn.toString)
                }
            } compactLeading: {
                Text(context.state.time, format: .number)
            } compactTrailing: {
                Text(context.state.nextTurn.toString)
            } minimal: {
                Text(context.state.nextTurn.toString)
            }
        }
    }
}
