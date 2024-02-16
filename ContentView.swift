import SwiftUI

struct ContentView: View {
    @AppStorage ("isOnBoarding") var isOnBoarding: Bool = true
    var body: some View {
        if isOnBoarding{
            WelcomePage()
        }else{
            
        }
    }
}
