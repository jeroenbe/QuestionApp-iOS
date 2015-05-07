//
//  Answer.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 07/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import Foundation
import CoreData

class Answer: NSManagedObject {

    @NSManaged var answer: NSNumber
    @NSManaged var qID: String
    @NSManaged var answerForQuestion: Question

}
