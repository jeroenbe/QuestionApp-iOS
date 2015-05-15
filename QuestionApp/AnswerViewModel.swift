//
//  AnswerViewModel.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 13/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import Foundation
import UIKit
import Meteor
import Bond

class AnswerViewModel{
    
    //Bound vars
    var question = Dynamic<String>("")
    var chartIsDisabled = Dynamic<Bool>(true)
    var spinnerShouldSpin = Dynamic<Bool>(true)
    var yesNoButtonIsEnabled = Dynamic<Bool>(true)
    
    //Meteor vars
    var currentQuestionID: String = "-1"
    var skip = false
    
    //Core Data vars
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func sendAnswer(answer: Bool, callback: METMethodCompletionHandler){
        Meteor.callMethodWithName("answerQuestion", parameters: [self.currentQuestionID, answer], completionHandler: callback)
    }
    
    func fetchAnswersForQuestion(callback: ([Double])->()){
        var skipped: Double = 0
        var yes: Double = 0
        var no: Double = 0
        
        let subscriptionLoader = SubscriptionLoader()
        
        subscriptionLoader.addSubscriptionWithName("answersForQuestion", parameters: self.currentQuestionID as String)
        
        subscriptionLoader.whenReady {
            let fetchRequest = NSFetchRequest(entityName: "Answer")
            let predicate = NSPredicate(format: "question == %@", self.currentQuestionID)
            
            fetchRequest.predicate = predicate
            
            if let fetchResults = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Answer]{
                for Answer in fetchResults{
                    if Answer.answer == true {
                        yes++
                    }else if Answer.answer == false {
                        no++
                    }else{
                        skipped++
                    }
                }
                callback([yes, no, skipped])
            }
        }
    }
    
    func setNextQuestion(){
        self.chartIsDisabled.value = true
        if(self.skip){
            Meteor.callMethodWithName("skipQuestion", parameters: [self.currentQuestionID]){
                void in
                self.getUnreadQuestion()
            }
        }else{
            self.getUnreadQuestion()
            self.skip = true
        }
    }
    
    func getUnreadQuestion(){
        self.spinnerShouldSpin.value = true
        //enableYesNo
        //set button to 'Skip Question'
        
        let subscriptionLoader = SubscriptionLoader()
        Meteor.callMethodWithName("getUnreadQuestion", parameters: []){
            questionID, error in
            
            var currentQuestionID = Meteor.objectIDForDocumentKey(METDocumentKey(collectionName: "questions", documentID: questionID))
            self.currentQuestionID = questionID as! String
            
            
            subscriptionLoader.addSubscriptionWithName("questionById", parameters: questionID)
            
            subscriptionLoader.whenReady {
                self.spinnerShouldSpin.value = false
                var question = (self.managedObjectContext?.existingObjectWithID(currentQuestionID, error: nil) as? Question)
                if let question = question {
                    self.question.value = question.content + "?"
                }
            }
        }
    }
    
    func answerQuestion(sender: AnyObject, callback: [Double] -> ()){
        var answer = false
        self.skip = false
        // set button to 'Next Question'
        
        if(sender.selectedSegmentIndex == 0){
            answer = true
        }
        
        self.sendAnswer(answer) {
            result in
            self.fetchAnswersForQuestion(){
                answers in
                
                callback(answers)
                
                
            }
        }
        sender.setEnabled(false, forSegmentAtIndex: (sender.selectedSegmentIndex-1)*(-1))
    }
}










