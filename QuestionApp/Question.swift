//
//  Question.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 03/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import Foundation
import CoreData

//@objc(Question)
class Question: NSManagedObject {

    @NSManaged var content: String
    @NSManaged var id: String
    @NSManaged var answersForQuestion: NSSet
    @NSManaged var authorForQuestion: NSManagedObject

}
