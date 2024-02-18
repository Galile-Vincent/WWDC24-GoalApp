import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage ("isOnBoarding") var isOnBoarding: Bool = true
    @Query var users: [UserData]
    @State var showsplash: Bool = true
    var body: some View {
        NavigationStack{
            ZStack{
                if isOnBoarding{
                    OnBoardingView()
                }else{
                    if showsplash{
                        SplashScreen()
                            .transition(.opacity)
                            .animation(.easeOut(duration: 1.5))
                    }else{
                        if let user = users.first {
                            Home(user: user)
                        }else{
                            //error
                        }
                    }
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.showsplash = false
                    }
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
