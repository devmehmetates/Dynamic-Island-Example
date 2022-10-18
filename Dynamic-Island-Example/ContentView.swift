//
//  ContentView.swift
//  Dynamic-Island-Example
//
//  Created by Mehmet Ateş on 18.09.2022.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State var time: Int = 300
    @State var activity: Activity<NavigationAttributes>?
    
    var body: some View {
        VStack {
            Button("Start activity") {
                startNavigation()
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    time -= 1
                    Task {
                        await updateNavigation()
                    }
                }
            }
            
            Button("Update activity") {
                Task {
                    await updateNavigation()
                }
            }
            
            Button("Stop activity") {
                Task {
                    await stopNavigation()
                }
            }
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
    
    func startNavigation() {
        let attr = NavigationAttributes(destination: "New York")
        let initialState = NavigationAttributes.NavigationStatus(nextTurn: .left, eta: Date(), time: time)
        do {
            let activity = try Activity<NavigationAttributes>.request(attributes: attr, contentState: initialState)
            self.activity = activity
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updateNavigation() async {
        await activity?.update(using: NavigationAttributes.NavigationStatus(nextTurn: .straight, eta: Date(), time: time))
    }
    
    func stopNavigation() async {
        await activity?.end()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
