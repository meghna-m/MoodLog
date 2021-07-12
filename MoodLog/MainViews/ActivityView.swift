//
//  CardView.swift
//  MoodLog
//
//  Created by Meghna . on 16/03/2021.
//

import SwiftUI

struct ActivityView: View {
    
    //binding variables for other views
    @State private var suggestion = suggested()
    @State private var showSheet = false
    

    var body: some View {
        NavigationView{
        VStack(alignment: .center) {
            Spacer()
            Text("Based on your current mood and other metrics we suggest \(suggestionEnding!)")
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
            
            //can navigate to expanded activity view when image is pressed
            NavigationLink(destination: ActivityExpandedView()){
                //shows image of the suggested activity
                Image(suggested())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .foregroundColor(Color.orange)
                    .padding()
                    .border(Color.orange, width: 5)
                    .cornerRadius(8)
                }
            Spacer()
        }   
     
        }.padding()
    }

}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
