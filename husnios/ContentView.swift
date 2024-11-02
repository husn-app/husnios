
import SwiftUI
import GoogleSignIn

enum AppState {
    case Startup
    case Login
    case Onboarding
    case Main
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
            case .Main: MainScreen().id(appState) // Use .id to ensure MainScreen is only computed when appState is .Main
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
