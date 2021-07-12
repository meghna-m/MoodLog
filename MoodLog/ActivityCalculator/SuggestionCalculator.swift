//
//  SuggestionCalculator.swift
//  MoodLog
//
//  Created by Meghna . on 12/03/2021.
//

import Foundation
import HealthKit
import CoreData

//Fetches steps data from HealthKit and returns the total step count for today as a Double
func fetchSteps() -> Double {
    let healthStore = HKHealthStore()
    var totalSteps = 0.0

    if HKHealthStore.isHealthDataAvailable() {
        //read step count and users sleep analysis
        let readData = Set([HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!, HKObjectType.quantityType(forIdentifier: .stepCount)!,HKObjectType.quantityType(forIdentifier: .dietaryWater)!] )
        
        //requests HealthKit authorization
        healthStore.requestAuthorization(toShare: [], read:readData) { (success, error) in
                if success {
                    //does data calling
                    guard let sampleType = HKCategoryType.quantityType(forIdentifier: .stepCount)
                    
                    else{
                        return
                    }
                    let startDate = Calendar.current.startOfDay(for: Date())
                    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
                    var interval = DateComponents()
                    interval.day = 1
                    
                    //query of data app wants to retrieve
                    let query = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate, intervalComponents: interval)
                    
                    //handles results of query
                    query.initialResultsHandler = {
                        query, result, error in
                        
                        if let myresult = result{
                            myresult.enumerateStatistics(from: startDate, to: Date()){ (statistic, value) in
                                
                                if let count = statistic.sumQuantity(){
                                    let val = count.doubleValue(for: HKUnit.count())
                                    totalSteps += val
                                }
                                
                            }
                        }
                    }
                    
                    healthStore.execute(query)
                    
        } else {
            print("No HealthKit data available")
    }
}
    }
    
    return totalSteps
}


//Fetches water intake data from HealthKit and returns the total water intake for today as a Double
func fetchWaterIntake() -> Double {
    let healthStore = HKHealthStore()
    var totalWater = 0.0

    if HKHealthStore.isHealthDataAvailable() {
        //read users water intake
        let readData = Set([HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!, HKObjectType.quantityType(forIdentifier: .stepCount)!,HKObjectType.quantityType(forIdentifier: .dietaryWater)!] )
        
        //requests HealthKit authorization
        healthStore.requestAuthorization(toShare: [], read:readData) { (success, error) in
                if success {
                    
                    //does data calling
                    guard let sampleType = HKCategoryType.quantityType(forIdentifier: .dietaryWater)
                    
                    else{
                        return
                    }
                    let startDate = Calendar.current.startOfDay(for: Date())
                    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
                    var interval = DateComponents()
                    interval.day = 1

                    //query of data I want to retrieve
                    let query = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: startDate, intervalComponents: interval)

                    //handles results of query
                    query.initialResultsHandler = {
                        query, result, error in
                        
                        if let myresult = result{
                            myresult.enumerateStatistics(from: startDate, to: Date()){ (statistic, value) in
                                
                                if let count = statistic.sumQuantity(){
                                    let val = count.doubleValue(for: HKUnit.count())
                                    totalWater += val
                                }
                                
                            }
                        }
                    }
                    //runs query
                    healthStore.execute(query)
                    
        } else {
            print("No HealthKit data available")
    }
}
    }
    
    return totalWater
}



//Fetches sleep hours data from HealthKit and returns the total sleep hours for the last 24H period as a Double

func readSleepHours(from startDate: Date?, to endDate: Date?) -> Double {
    
    let healthStore = HKHealthStore()
    
    //vaiable to set total sleeo hours
    var totalSleep = 0.0
    
    //define obejct of sleepe
    guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
        return 0.0
    }
    
    //used to filter data
    let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

    // used to show sort data to be descending
    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

    //  query to search healthKit for user sleep
    let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 0, sortDescriptors: [sortDescriptor]) { (query, results, error) in
        guard error == nil else {
            // handle error
            //print("Something went wrong getting sleep analysis: \(String(describing: error))")

            return
        }
        
        //variable for users total sleep in minutes/hours
        var minutesSleepAggr = 0.0

        if let result = results {
            for item in result{
                if let sample = item as? HKCategorySample{
                    
                    if sample.value == HKCategoryValueSleepAnalysis.asleep.rawValue{
                        let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value)
                        let isAsleep = sleepValue == .asleep

                        let sleepTime = sample.endDate.timeIntervalSince(sample.startDate)
                        let minutesInAnHour = 60.0
                        
                        let minutesBetweenDates = sleepTime / minutesInAnHour
                        
                        minutesSleepAggr += minutesBetweenDates
                        
                        let officialHours = Double(String(format: "%.1f", minutesSleepAggr / 60))!
                        
                        totalSleep += officialHours

                    }
                     
                }
            }
           
        }
    }

    // Execute query
    healthStore.execute(query)
    return totalSleep
}


//creates yesterday date used for readSleepHours query
extension Date {
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}

let yesterday = Date().dayBefore

//calculates a suggested activity based on the users mood, sleep, step count and water intake
func calculateActivity() -> String{
    
    var mood = ""
    
    if lastMood.isEmpty {
        mood = "Neutral"
    } else{
        mood = lastMood[0]
    }
    
    var activity = ""
    let model = MoodClassifierActicity()
    
    do {
        let prediction = try model.prediction(Mood: mood, Sleep: readSleepHours(from: yesterday, to: Date()), Steps: fetchSteps(), Water: fetchWaterIntake())
        
        activity = prediction.Activity
        
        print ("The Suggested Activity is: \(activity)")
        print (mood)
        
    } catch{
        print(error)
    }
    return activity
}


