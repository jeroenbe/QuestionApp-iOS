//
//  ChartViewModel.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 13/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import Foundation
import Bond
import CoreData

import UIKit

class ChartViewModel {
    var chartIsHidden = Dynamic<Bool>(true)
    
    var yes = Dynamic<Double>(0)
    var no = Dynamic<Double>(0)
    var skipped = Dynamic<Double>(0)
    
    var yesForLabel = Dynamic<String>("0")
    var noForLabel = Dynamic<String>("0")
    var skippedForLabel = Dynamic<String>("0")
    
    //Core Data vars
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    func fetchAnswersForQuestion(currentQuestionID: String, callback: ([Double])->()){
        self.resetAnswers()
        
        let subscriptionLoader = SubscriptionLoader()
        subscriptionLoader.addSubscriptionWithName("answersForQuestion", parameters: currentQuestionID as String)
        
        subscriptionLoader.whenReady {
            let fetchRequest = NSFetchRequest(entityName: "Answer")
            let predicate = NSPredicate(format: "question == %@", currentQuestionID)
            
            fetchRequest.predicate = predicate
            
            if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Answer]{
                for Answer in fetchResults{
                    if Answer.answer == true {
                        self.yes.value++
                    }else if Answer.answer == false {
                        self.no.value++
                    }else{
                        self.skipped.value++
                    }
                }
                callback([self.yes.value, self.no.value, self.skipped.value])
            }
        }
    }
    
    func updateAnswerCount(yes: Double, no: Double, skipped: Double){
        self.yesForLabel.value =  "\(Int(yes))"
        self.noForLabel.value = "\(Int(no))"
        self.skippedForLabel.value = "\(Int(skipped))"
    }
    func resetCounts(){
        self.yesForLabel.value = "0"
        self.noForLabel.value = "0"
        self.skippedForLabel.value = "0"
    }
    
    func resetAnswers(){
        self.yes.value = 0
        self.no.value = 0
        self.skipped.value = 0
    }
}