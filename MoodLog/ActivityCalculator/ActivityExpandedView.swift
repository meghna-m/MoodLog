//
//  ActivityExpandedView.swift
//  MoodLog
//
//  Created by Meghna . on 23/03/2021.
//

import SwiftUI

struct ActivityExpandedView: View {
    
    //private variables used to show sheets
    @State private var ratingSheet = false
    @State private var calendarSheet = false
    
    //private variable used for suggested activity
    @State private var suggestion = suggested()
    
//shows the expansion on the suggested activity
    var body: some View {
        VStack(alignment: .center) {
        Text("If you're stuck on where to start we suggest, \(expansionEnding!)")
            .font(.title)
            .multilineTextAlignment(.center)
            Spacer()
            //opens relevant link for activity when button is pressed
            Button(action: {
                UIApplication.shared.open(usefulLink!)
                
            }) {
                Text(buttonTitle!)
            }.foregroundColor(.white)
            .padding()
            .background(Color.orange).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            .clipShape(Capsule())
            .frame(width: 200, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            //button to add event to calndar
            Button(action:{
                self.calendarSheet.toggle()
            }){
                Text("Add to Calendar").sheet(isPresented: $calendarSheet, content: {AddEventView()})
            }.foregroundColor(.white)
            .padding()
            .background(Color.pink).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            .clipShape(Capsule())
            .frame(width: 200, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            Spacer()
            
            //button to log the activty and rate it as well
            Button(action:{
                self.ratingSheet.toggle()
            }){
                Text("Log Activity").sheet(isPresented: $ratingSheet, content: {
                    SuggestionReviewView(activity: $suggestion)
                })
            }.foregroundColor(.white)
            .padding()
            .background(Color.blue).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            .clipShape(Capsule())
            .frame(width: 150, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            Spacer()
            
        }.padding()
    }
}

struct ActivityExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityExpandedView()
    }
}
