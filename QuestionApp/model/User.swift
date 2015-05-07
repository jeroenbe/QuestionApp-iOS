//
//  User.swift
//  QuestionApp
//
//  Created by Jeroen Berrevoets on 07/05/15.
//  Copyright (c) 2015 Jeroen Berrevoets. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var authoredQuestions: NSSet

}
