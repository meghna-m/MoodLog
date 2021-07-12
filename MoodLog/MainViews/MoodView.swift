//
//  MoodView.swift
//  MoodLog
//
//  Created by Meghna . on 03/02/2021.
//

import SwiftUI
import CoreData
import EventKit

//dictionary of logged moods on current run
var loggedMoods : [Date:String] = [:]

//Sorts dictionay by date
let dictValInc = loggedMoods.sorted(by: { $0.value < $1.value })

//stores a valuse of the most recent mood used to create predicted activity
var lastMood : [String] = []

//Mood View
struct MoodView: View {
    

    @Environment(\.managedObjectContext) private var viewContext
        
//CoreData fetch request for Moods
    @FetchRequest(fetchRequest: Moods.fetchRequestLimit1()) var feelings1: FetchedResults<Moods>
    
    //private var to track mood
    @State private var mood = "default"
    
    //private var to track 'Log Mood' button being pressed
    @State private var buttonPressed = false
    
    //Array of moods for user to choose from
    let moods = ["Happy", "Calm","Neutral", "Stressed", "Sad", "Fustrated"]
    
//colums for grid layout of moods
        var columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    //sets current time used to log mood
    let now = Date()

    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Text("How are you feeling?")
                    .font(.title)
            Spacer()
                //creates grid structure
                LazyVGrid(columns: columns, spacing: 50) {
                    ForEach(moods, id: \.self) { item in
                        Button(action: {
                            self.mood = item
                        }) {
                            Text(item)
                        }
                    }.foregroundColor(.white)
                    .padding()
                    .background(Color.orange).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    .clipShape(Capsule())
                    .frame(width: 110, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                }
                .padding(.horizontal)
                
            Spacer()
              
                Button(action: {
                    self.buttonPressed.toggle()
                    loggedMoods[now] = mood
                    let newMood = Moods(context: viewContext)
                    newMood.mood = self.mood
                    newMood.date = self.now
                    
                   // save new mood
                    do {
                        try viewContext.save()
                        print("Mood Logged.")
                        
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                    //assigns last mood logged to variable
                    lastMood += feelings1.compactMap{ $0.value(forKey: "mood") as? String}
                    
                    //runs calculateActivity function -> used for activity page
                    suggestedActivity = calculateActivity()
                    
                }) {
                    Text("Log Mood")
                }.foregroundColor(.white)
                .padding()
                .background(Color.blue).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .clipShape(Capsule())
                .frame(width: 110, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
              
            }
        }.padding()
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView()
    }
}
