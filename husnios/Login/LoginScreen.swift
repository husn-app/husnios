import SwiftUI
import GoogleSignInSwift
import AuthenticationServices

// TODO: This is okay for first time users. For users who are registered
// and try to login, it'll take them to onboarding and then quickly to MainScreen
// This is okay but for now but can be later fixed by keeping state variables isOnboarded/isLoggedIn
// in ContentView along with appState
struct LoginScreen: View {
    @Binding var appState: AppState
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text("Husn")
                .font(.custom("Zapfino", size: 72))
                .foregroundColor(.primary)
                .padding(.vertical, 0)
            //                .padding(.bottom, 50)
            
            
            VStack {
                GoogleSignInButton(
                    scheme:(colorScheme == ColorScheme.dark ? .dark : .light),
                    style : .wide,
                    action: {
                        handleSignInButton { success in
                            if success {
                                appState = .Onboarding
                            }
                        }
                    }).frame(width: 180)
                    .cornerRadius(12)
                
            }
            .scaleEffect(x: 1.8, y: 1.8)
            
            SignInWithAppleButton(
                onRequest: handleAppleRequest,
                onCompletion: { result in
                    handleAppleSignIn(result) { success in
                        if success {
                            appState = .Onboarding
                        }
                    }
                }
            ).frame(height: 120)
            
            Spacer()
            
        }.background(
            Image(colorScheme == ColorScheme.dark ? "dark-background" : "light-background")
                .resizable()
                .frame(width: 900, height: 1600)
                .ignoresSafeArea()
        )
    }
}


#Preview {
    LoginScreen(appState: .constant(.Login))
}
