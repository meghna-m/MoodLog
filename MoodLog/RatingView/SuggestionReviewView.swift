//
//  SuggestionReviewView.swift
//  MoodLog
//
//  Created by Meghna . on 20/02/2021.
//

import SwiftUI
import CoreData

struct SuggestionReviewView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    //binding variable for activity
    @Binding var activity: String
    
    //value for user rating
    @State private var rating = 0
    @State private var submitted = false
    
    //used to close sheet once rating submitted
    @Environment(\.presentationMode) var presentationMode


    //View for user to rate their suggested activity
    var body: some View {
        NavigationView{
            VStack{
                Text("How did you find \(activity)? Please rate below:")
                    .font(.title)
                    .multilineTextAlignment(.center)
            Spacer()
                RatingView(rating: $rating)
                Spacer()
                //Logs the suggested activity and the user rating to CoreData
                Button(action:{
                    let newActivityRating = ActivityRatings(context: viewContext)
                    newActivityRating.activity = activity
                    newActivityRating.rating = Int16(finalRating)
                    newActivityRating.date = Date()
                    print(newActivityRating.activity)
                    print(newActivityRating.rating)
                    do {
                        try viewContext.save()
                        print("Activity Rating Logged")
                        presentationMode.wrappedValue.dismiss()
                        
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                }){
                    Text("Submit")
                }.foregroundColor(.white)
                .padding()
                .background(Color.blue).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .clipShape(Capsule())
                .frame(width: 150, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }
        }
    }
}

struct SuggestionReviewView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionReviewView(activity: .constant("some activity")  )
    }
}
