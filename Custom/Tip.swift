import TipKit

struct addmstip: Tip{
    var title: Text{
        Text("Click to add new Short-term goals")
    }
    var message: Text?{
        Text("You can add your new Short-term goals in the goal")
    }
    var rules: [Rule] {
            #Rule(Self.$hasViewedGetStartedTip) { $0 == true }
        }

        @Parameter
        static var hasViewedGetStartedTip: Bool = false
}

struct addgoal: Tip{
    var title: Text{
        Text("Click to add new goal")
    }
    var message: Text?{
        Text("You can add new goals")
    }
    var rules: [Rule] {
            #Rule(Self.$hasViewedGetStartedTip) { $0 == true }
        }

        @Parameter
        static var hasViewedGetStartedTip: Bool = false
    
}
