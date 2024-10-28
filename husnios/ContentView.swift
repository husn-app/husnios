
import SwiftUI
import GoogleSignIn

enum AppState {
    case Startup
    case Login
    case Onboarding
    case Main
}

private func checkIfUserIsLoggedIn(completion: @escaping (Bool) -> Void) {
    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
        if let user = user {
            print("User is logged in: \(user.profile?.name ?? "Unknown") \(user.profile?.email)")
            completion(true)
        } else {
            // Handle error if needed
            print("User is not logged in. Error: \(error?.localizedDescription ?? "Unknown error")")
            completion(false)
        }
    }
}

private func checkIfUserIsOnboarded(completion: @escaping (Bool) -> Void) {
    if let cookies = HTTPCookieStorage.shared.cookies {
        for cookie in cookies {
            if cookie.name == "onboarding_stage" {
                completion(cookie.value == "COMPLETE")
                return
            }
        }
    }
    completion(false)
}

struct ContentView: View {
    @State var appState: AppState = .Startup
    
    var body: some View {
        Group {
            switch appState {
            case .Startup : LoadingScreen()
            case .Login : LoginScreen(appState: $appState)
            case .Onboarding: OnboardingScreen(appState: $appState)
            case .Main: MainScreen(selectedTab: Tab.Home)
            }
        }
        .onAppear(perform: handleAppState)
        .onChange(of: appState, perform: { _ in
            handleAppState()
        })
    }
    
    private func handleAppState() {
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            checkIfUserIsLoggedIn { isLoggedIn in
                if (!isLoggedIn) {
                    appState = .Login
                    return
                }
                
                checkIfUserIsOnboarded { isOnboarded in
                    if (!isOnboarded) {
                        appState = .Onboarding
                        return
                    } else {
                        appState = .Main
                        return
                    }
                }
            }
       }
    }
}

#Preview {
    ContentView(appState: .Main)
}
