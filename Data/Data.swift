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
    var quotes: [String]
    @Relationship(deleteRule: .cascade, inverse: \GoalData.user) var Goal = [GoalData]()
    init(username: String, quotes: [String], Goal: [GoalData] = [GoalData]()) {
        self.username = username
        self.quotes = quotes
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
    
    
    func totalMilestoneCount() -> Int {
        return milestone.count
    }
    
    func DoneMilestoneCount() -> Int {
        return milestone.filter { $0.status == 2 }.count
    }

    func inProgressMilestoneCount() -> Int {
        return milestone.filter { $0.status == 1 }.count
    }
    
    func NotStartedMilestoneCount() -> Int {
        return milestone.filter { $0.status == 0 }.count
    }
}


@Model
final class MileStone{
    var name: String
    var detail: String
    var status: Int
    @Relationship(deleteRule: .cascade) var tasks = [Tasks]()
    init(name: String, detail: String, status: Int, tasks: [Tasks] = [Tasks]()) {
        self.name = name
        self.detail = detail
        self.status = status
        self.tasks = tasks
    }
    var goal: GoalData?
    
    func updateStatus() {
        // Count the number of completed tasks
        let completedCount = tasks.filter { $0.isCompleted }.count
        let total = tasks.filter { $0.isCompleted == true || $0.isCompleted == false }.count
        // Update status if completedCount is not 0
        if total == completedCount {
            self.status = 2
        }
        else if completedCount != 0 {
            self.status = 1
        }
        else if completedCount == 0 {
            self.status = 0
        }
    }
    
}


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
 
