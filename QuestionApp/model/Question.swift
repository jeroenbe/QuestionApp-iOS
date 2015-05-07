//
//  Question.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 07/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import Foundation
import CoreData

class Question: NSManagedObject {

    @NSManaged var content: String
    @NSManaged var id: String
    @NSManaged var answersForQuestion: NSSet
    @NSManaged var authorForQuestion: User

}
