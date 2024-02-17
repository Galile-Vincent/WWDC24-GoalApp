//
//  Data.swift
//
//
//  Created by Vincent Chiang on 2024/2/16.
//

import SwiftData

@Model
final class UserData{
    var username: String
    @Relationship(deleteRule: .cascade, inverse: \Quotes.user) var Quote = [Quotes]()
    @Relationship(deleteRule: .cascade, inverse: \GoalData.user) var Goal = [GoalData]()
    init(username: String, Quote: [Quotes] = [Quotes](), Goal: [GoalData] = [GoalData]()) {
        self.username = username
        self.Quote = Quote
        self.Goal = Goal
    }
}

@Model
final class Quotes{
    var quote: String
    init(quote: String) {
        self.quote = quote
    }
    var user: UserData?
}

@Model
final class GoalData{
    var goal: String
    var goal_describe: String
    @Relationship(deleteRule: .cascade, inverse: \MileStone.goal) var milestone = [MileStone]()
    init(goal: String, goal_describe: String, milestone: [MileStone] = [MileStone]()) {
        self.goal = goal
        self.goal_describe = goal_describe
        self.milestone = milestone
    }
    var user: UserData?
}


@Model
final class MileStone{
    var name: String
    var detail: String
    var status: Status?
    init(name: String, detail: String, status: Status? = nil) {
        self.name = name
        self.detail = detail
        self.status = status
    }
    var goal: GoalData?
    
}

extension MileStone {
    enum Status: Int, CaseIterable, Codable {
        case notstarted = 0
        case inprogress = 1
        case done = 2
    }
}
