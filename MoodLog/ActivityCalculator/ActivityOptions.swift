//
//  ActivityOptions.swift
//  MoodLog
//
//  Created by Meghna . on 16/03/2021.
//

import Foundation
import CoreData

//assigns suggested activity
var suggestedActivity = calculateActivity()

//dictionary for the appropriate activity suggestion sentence based on activity
let activityAndSentence = ["Yoga":"you try a Yoga Session", "Water":"you drink a glass of water", "Walk":"you go for a short walk", "Read": "you read a book", "Meditation":"you do a short meditation", "Journal": "you do a journal entry" ]

//assigns suggestion ending to be used on activity page
let suggestionEnding = activityAndSentence[suggested()]

//assigns relevant URL to variable
var usefulLink =  walkingBenefits

//
var position = 0

//runs the approriate function depending on the suggested activity
func suggested() -> String{
    
    var activity = ""
    
switch suggestedActivity {

case "Yoga":
    print("yoga function -> sun.haze")
    activity = "Yoga"
    //suggestionEnding = "you try a Yoga Session"
    position = 0
    usefulLink = YogaLink()
    
case "Water":
    print("water function -> drop")
    activity = "Water"
    //suggestionEnding = "you drink a glass of water"
    position = 1
    usefulLink = waterBenefits
    
case "Walk":
    print("Walk function -> figure.walk")
    activity = "Walk"
    //suggestionEnding = "you go for a short walk"
    position = 2
    usefulLink = walkingBenefits
    
case "Read":
    print("Read function -> book")
    activity = "Read"
    //suggestionEnding = "you read a book"
    position = 3
    usefulLink = freeBooks

case "Meditation":
    print("Meditation function -> eyebrow")
    activity = "Meditation"
    //suggestionEnding = "you do a short meditation"
    position = 5
    usefulLink = MeditationLink()

case "Journal":
    print("Journal function -> teztbook.closed")
    activity = "Journal"
    //suggestionEnding = "you do a journal entry"
    position = 6
    usefulLink = journalingMethods

default:
    "Cannot find suggested activity"
}
    //print(suggestionEnding)
    return activity
    
}

