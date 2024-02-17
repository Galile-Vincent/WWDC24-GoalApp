import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage ("isOnBoarding") var isOnBoarding: Bool = true
    @Query var users: [UserData]
    var body: some View {
        NavigationView{
            if isOnBoarding{
                OnBoardingView()
            }else{
                if let user = users.first {
                    Home(user: user)
                }else{
                    //error
                }
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
