//
//  ActivitesExpanded.swift
//  MoodLog
//
//  Created by Meghna . on 18/03/2021.
//

import Foundation

//dictionary for the detailed activity
let activityAndExpansion = ["Yoga":"try this short Yoga Session", "Water":"drink \(SuggestedWater(waterDrank: fetchWaterIntake())/250) glasses of water", "Walk":"you go for a \(SuggestedSteps(stepsTaken: fetchSteps())/100) minute walk", "Read": "read a book of your choice for 30 minutes", "Meditation":"you try this short meditation", "Journal": "you do a short journal entry" ]

let expansionEnding = activityAndExpansion[suggested()]

//dictionary for the button url text
let activityExpansionDetail = ["Yoga":"Watch Video", "Water":"Benefits of Drinking Water", "Walk":"Benefits of Walking", "Read": "Free Books to read", "Meditation":"Play Meditation Video", "Journal": "Journaling Techniques" ]

let buttonTitle = activityExpansionDetail[suggested()]

//Array of possible Yoga videos
let yogaVidsString = ["https://www.youtube.com/watch?v=Enz98dDXQfY&list=PLui6Eyny-UzwDdFPVSeYN3aTG_B1qtHtz&index=7","https://www.youtube.com/watch?v=wwPzwZo6vdk&list=PLui6Eyny-UzwDdFPVSeYN3aTG_B1qtHtz&index=8","https://www.youtube.com/watch?v=tD_l3fDTFyg&list=PLui6Eyny-UzwDdFPVSeYN3aTG_B1qtHtz&index=14","https://www.youtube.com/watch?v=qiKJRoX_2uo&list=PLui6Eyny-UzwDdFPVSeYN3aTG_B1qtHtz&index=21","https://www.youtube.com/watch?v=icfwMWYDeac&list=PLui6Eyny-UzwDdFPVSeYN3aTG_B1qtHtz&index=28"]

//creates URL of yoga video
let yogaVidsURL = yogaVidsString.compactMap{URL(string: $0)}

//assigns a random integer within range of the Yoga Video Array
let randomIntYoga = Int.random(in: 0..<yogaVidsString.count)

//Array of possible meditation videos
let meditationVidsString = ["https://www.youtube.com/watch?v=QHkXvPq2pQE","https://www.youtube.com/watch?v=sG7DBA-mgFY", "https://www.youtube.com/watch?v=cZJAsW_5SRA","https://www.youtube.com/watch?v=7P1JlwkXvw8","https://www.youtube.com/watch?v=uNHLhHyjbd0"]

//creates URL of meditation video
let meditationVidsURL = meditationVidsString.compactMap{URL(string: $0)}

//assigns a random integer within range of the Meditation Video Array
let randomIntMeditation = Int.random(in: 0..<meditationVidsString.count)

//assigns URL for drinking water benefits
let waterBenefits = URL(string: "https://www.chss.org.uk/supportus/hps/water-for-wellness/")

//assigna URL for walking benefits
let walkingBenefits = URL(string: "https://www.bupa.co.uk/newsroom/ourviews/walking-health")

//assigns URL for books to read
let freeBooks = URL(string: "https://manybooks.net")

//assigns URL for different journaling methods
let journalingMethods = URL(string: "https://vanillapapers.net/2020/08/25/journaling-techniques/")

//returns a suggested amount of water to drink
func SuggestedWater(waterDrank: Double) -> Double {
    
    switch waterDrank {
    case 2000 ... 3000:
        return 250.00
    
    case 1000 ... 1999:
        return 500.00

    case 500 ... 999:
        return 750.00
        
    case let x where x < 499:
        return 1000.00

    default:
        return 0.0
    }
}

//returns a suggested amount of steps to take 
func SuggestedSteps(stepsTaken: Double) -> Int {
    
    switch stepsTaken {
    case let x where x >= 8000:
        return 1000
    
    case 6000 ... 7999:
        return 1000

    case 4000 ... 5999:
        return 2000
        
    case let x where x < 3999:
        return 3000

    default:
        return 0
    }
}

//returns a suggestes yoga video URL
func YogaLink() -> URL{
    return yogaVidsURL[randomIntYoga]
}

//returns a suggestes meditation video URL
func MeditationLink() -> URL{
    return meditationVidsURL[randomIntMeditation]
}


