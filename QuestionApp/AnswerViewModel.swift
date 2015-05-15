//
//  AnswerViewModel.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 13/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import Foundation
import Meteor
import Bond

class AnswerViewModel{
    
    var chartViewModel = ChartViewModel()
    
    //Bound vars
    var question = Dynamic<String>("")
    var chartIsDisabled = Dynamic<Bool>(true)
    var spinnerShouldSpin = Dynamic<Bool>(true)
    var yesNoButtonIsEnabled = Dynamic<Bool>(true)
    var nextQuestionForButton = Dynamic<String>("Skip Question")
    
    //Meteor vars
    var currentQuestionID: String = "-1"
    var skip = false
    
    //Core Data vars
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func sendAnswer(answer: Bool, callback: METMethodCompletionHandler){
        Meteor.callMethodWithName("answerQuestion", parameters: [self.currentQuestionID, answer], completionHandler: callback)
    }
    
    func fetchAnswersForQuestion(callback: ([Double])->()){
        self.chartViewModel.fetchAnswersForQuestion(self.currentQuestionID){
            answers in
                callback(answers)
        }
    }
    
    func setNextQuestion(){
        self.chartViewModel.chartIsHidden.value = true
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
        self.nextQuestionForButton.value = "Skip Question"
        
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
    
    func answerQuestion(sender: AnyObject, callback: ([Double]) -> ()){
        var answer = false
        self.makeViewReadyForNewQuestion()
        
        if(sender.selectedSegmentIndex == 0){
            answer = true
        }
        
        self.sendAnswer(answer) {
            result in //result = Reply of Server - not needed here but needed for compiler
            
            self.fetchAnswersForQuestion(){
                answers in
                
                callback(answers)
            }
        }
        //TODO for bindings
        sender.setEnabled(false, forSegmentAtIndex: (sender.selectedSegmentIndex-1)*(-1))
    }
    
    func makeViewReadyForNewQuestion(){
        self.skip = false
        self.nextQuestionForButton.value = "Next Question"
        self.chartViewModel.resetCounts()
    }
}










