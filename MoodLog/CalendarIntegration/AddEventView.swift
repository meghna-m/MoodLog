//
//  AddEventView.swift
//  MoodLog
//
//  Created by Meghna . on 24/03/2021.
//

import SwiftUI

struct AddEventView: View {
    
    //sets CaldendarFunction class
    let variable = CalendarFunction()
  
    @Environment(\.presentationMode) var presentationMode

    //set todays date
    @State private var today = Date()

    var body: some View {
        NavigationView{
        VStack {
            Text("Add \(suggested().lowercased()) to your calendar ")
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
            
            //date picker
            DatePicker(selection: $today, displayedComponents:[ .hourAndMinute, .date]){
                        Text("Select a date")
                            .multilineTextAlignment(.center)
            }.padding()
            Spacer()
            
            //adds event to calndar when user presses it
            Button(action:{
                variable.checkPermission(startDate: today, endDate: variable.endTime(activity: suggestedActivity), eventName: suggested())
                presentationMode.wrappedValue.dismiss()
            }){
            Text("Submit")
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            .clipShape(Capsule())
            .frame(width: 150, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            Spacer()

        }
            
        }
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
    }
}
