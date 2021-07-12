//
//  SettingsView.swift
//  MoodLog
//
//  Created by Meghna . on 03/02/2021.
//

import SwiftUI
import HealthKit

var star = Image(systemName: "star.fill")


//Settings View
    struct SettingsView: View {
        
        @Environment(\.managedObjectContext) private var viewContext

        //fetches recent activity ratings from core data
        @FetchRequest(entity: ActivityRatings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ActivityRatings.date, ascending: true)]) var activityRatings: FetchedResults<ActivityRatings>
        
        //fetches recent mood loggings from core data
        @FetchRequest(entity: Moods.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ActivityRatings.date, ascending: true)]) var loggedMoods: FetchedResults<Moods>
        
        //user to formate date for UI
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter
          }
        
        //updates activity ratings to sort into dictionary
        func update(_ result : FetchedResults<ActivityRatings>)-> [[ActivityRatings]]{
              return  Dictionary(grouping: result){ (element : ActivityRatings)  in
                dateFormatter.string(from: element.date!)
              }.values.map{$0}
            }
        
        //updates moods to sort into dictionary
        func update2(_ result : FetchedResults<Moods>)-> [[Moods]]{
          return  Dictionary(grouping: result){ (element : Moods)  in
            dateFormatter.string(from: element.date)
          }.values.map{$0}
        }
        
 
        var body: some View {
            VStack(alignment: .center){
                Spacer()
                Text("Overview")
                    .font(.title)
                Spacer()
                Spacer()
                
                Text("Activies")
                
                //displays a list of the activites done and the user rating for them
                List {
                        ForEach(update(activityRatings), id: \.self) { (section: [ActivityRatings]) in
                            Section(header: Text( self.dateFormatter.string(from: section[0].date!))) {
                                ForEach(section, id: \.self) { todo in
                            HStack {
                                Spacer()
                            Text(todo.activity ?? "")
                                Spacer()
                                Spacer()
                            Text("\(todo.rating)") + Text(Image(systemName: "star"))
                                Spacer()
                            }
                            }
                          }
                        }.id(activityRatings.count)
                      }.listStyle(InsetGroupedListStyle())
                
                Text("Moods")
                
                //displays a list of the moods a user has logged
                List {
                        ForEach(update2(loggedMoods), id: \.self) { (section: [Moods]) in
                            Section(header: Text( self.dateFormatter.string(from: section[0].date))) {
                                ForEach(section, id: \.self) { todo in
                            HStack {
                            Text(todo.mood ?? "")
                              
                            }
                            }
                          }
                        }.id(activityRatings.count)
                      }.listStyle(InsetGroupedListStyle())
            
            }.padding()
        }
    }

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
