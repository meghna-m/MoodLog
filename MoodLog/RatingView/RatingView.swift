//
//  RatingView.swift
//  MoodLog
//
//  Created by Meghna . on 17/02/2021.
//

import SwiftUI

var finalRating = 0

//creates star view
struct RatingView: View {
    //binding variable for number of stars to be highlighted
    @Binding var rating: Int

    var label = ""
    //maximum star rating
    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            //runs image function for each star
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                        finalRating = number
                    }
            }
        }
    }
    
    //on or off star
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        //default value set
        RatingView(rating: .constant(4))
    }
}
