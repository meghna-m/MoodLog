//
//  CalendarFunction.swift
//  MoodLog
//
//  Created by Meghna . on 15/03/2021.
//

import Foundation
import EventKit

let eventStore = EKEventStore()

//protocol of Calendar Function
protocol CalendarFunctionProtocol {
    
    func insertEvent(store: EKEventStore, startDate: Date, endDate: Double, eventName : String )
    func checkPermission(startDate: Date, endDate: Double, eventName : String )
}

//Class of calndar function
class CalendarFunction : CalendarFunctionProtocol{
    private var store = EKEventStore()

   
    //function that returns the corresponding endtime for the activity
    func endTime(activity: String) -> Double{
        
        var endTime : Double
        
        if (activity == "Yoga" || activity == "Water" || activity == "Meditation"){
            endTime = 15.00
        }else{
            endTime = 30.0
        }
        return endTime
    }
    
    //function to check that the user has set calendar permission
    func checkPermission(startDate: Date, endDate: Double, eventName: String){
        let eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatus(for: .event){
        case.notDetermined:
            eventStore.requestAccess(to: .event) { (status, error) in
                if status{
                    //runs insertEvent if permission is granted
                    self.insertEvent(store: EKEventStore.init(), startDate: startDate,endDate: endDate, eventName: eventName)
                }else{
                    print(error?.localizedDescription)
                }
            }
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorized:
            //runs insertEvent if permission is granted
            self.insertEvent(store: EKEventStore.init(), startDate: startDate,endDate: endDate, eventName: eventName)
        @unknown default:
            print("unknown")
        }
    }
    
    
   //function to insert event
    func insertEvent(store: EKEventStore, startDate: Date, endDate: Double, eventName : String ) {
        
        let calendars = store.calendars(for: .event)

        for calendar in calendars {

            if calendar.title == "Calendar" {
                let startDate = startDate

                let endDate = startDate.addingTimeInterval(endDate * 60)
                    
                let event = EKEvent(eventStore: store)
                event.calendar = calendar
                
                //asigns event name, start time&date and end time&date
                event.title = eventName
                event.startDate = startDate
                event.endDate = endDate
                    
                do {
                    try store.save(event, span: .thisEvent)
                }
                catch {
                   print("Error saving event in calendar")             }
                }
        }
    }
}


