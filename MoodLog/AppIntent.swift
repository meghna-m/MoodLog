//
//  AppIntent.swift
//  MoodLog
//
//  Created by Meghna . on 17/03/2021.
//

import Foundation
import Intents
class AppInent{
    
    //requests permission to user Siri
    class func allowSiri(){
        INPreferences.requestSiriAuthorization { status in
            
            switch status{
            case.notDetermined,
                .restricted,
                .denied:
                print("Siri Error")
            
            case.authorized:
                print("Siri good")
                            
            }
            
        }
    }
    
    //adds mood from user dictation
    class func mood() {
        let intent = MoodIntent()
        intent.suggestedInvocationPhrase = "Log Mood"
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate{ error in
            if let error = error as NSError?{
                print("Interaction donation failed: \(error.description)")
            }else{
                print("Successfully donated interaction")
            }
        }
    }
    
}
