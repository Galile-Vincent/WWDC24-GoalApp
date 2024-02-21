//
//  Data.swift
//
//
//  Created by Vincent Chiang on 2024/2/16.
//

import SwiftData
import Foundation
@Model
final class UserData{
    var username: String
    @Relationship(deleteRule: .cascade, inverse: \GoalData.user) var Goal = [GoalData]()
    init(username: String, Goal: [GoalData] = [GoalData]()) {
        self.username = username
        self.Goal = Goal
    }
}


@Model
final class GoalData{
    let id: UUID 
    var goal: String
    var goal_describe: String
    @Relationship(deleteRule: .cascade, inverse: \MileStone.goal) var milestone = [MileStone]()
    init(goal: String, goal_describe: String, milestone: [MileStone] = [MileStone]()) {
        self.id = UUID()
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
    var status: Int
    var tasks: [String]
    //@Relationship(deleteRule: .cascade, inverse: \Tasks.name) var task = [Tasks]()
    init(name: String, detail: String, status: Int, tasks: [String]) {
        self.name = name
        self.detail = detail
        self.status = status
        self.tasks = tasks
    }
    var goal: GoalData?
    
}

/*
 @Model
 final class Tasks{
 var name: String
 var isCompleted: Bool
 init(name: String, isCompleted: Bool) {
 self.name = name
 self.isCompleted = isCompleted
 }
 var milestone: MileStone?
 
 }
 */
