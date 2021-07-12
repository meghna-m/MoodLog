//
//  ContentView.swift
//  MoodLog
//
//  Created by Meghna . on 22/12/2020.
//

import SwiftUI

//First View run

struct ContentView: View {

    var body: some View {
        //Bottom bar selectable Tab view
                TabView() {
                    MoodView()
                        .tabItem {
                            Image(systemName: "heart")
                            Text("Mood")
                            
                        }
                    ActivityView()
                        .tabItem {
                            Image(systemName: "bolt")
                            Text("Activitiy")
                        }
                    SettingsView()
                        .tabItem {
                            Image(systemName: "poweroff")
                            Text("Overview")
                        }
                }
    }
}
    
    //Code given in project creation
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
    
    //Code given in project creation
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

