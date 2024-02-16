import SwiftUI

struct ContentView: View {
    @AppStorage ("isOnBoarding") var isOnBoarding: Bool = true
    var body: some View {
        NavigationView{
            if isOnBoarding{
                OnBoardingView()
            }else{
                
            }
        }
    }
}


struct OnBoardingView: View {
    @EnvironmentObject var login: Login
    var body: some View {
        if login.page == 0{
            WelcomePage()
        }else if login.page == 1{
            UserInfo()
        }
    }
}
