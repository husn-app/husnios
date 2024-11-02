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
    @State private var showMoreOptions = false
    
    var body: some View {
        VStack {
            Text("Husn")
                .font(.custom("Zapfino", size: 72))
                .foregroundColor(.black)
                .padding(.vertical, 0)
            //                .padding(.bottom, 50)
            
            VStack {
                Button(
                    action: {
                        handleSignInButton { success in
                            if success {
                                appState = .Onboarding
                            }
                        }
                    }
                ) {
                    Image("GoogleSignInButtonDark")
                        .resizable()
                        .aspectRatio(contentMode:.fit)
                        .frame(width: 180)

                }
                //                .cornerRadius(8)
                
                
                if (!showMoreOptions) {
                    Button(action: {
                        showMoreOptions.toggle()
                    }) {
                        Text("Show more options >")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    
                }
                
                if showMoreOptions {
                    SignInWithAppleButton(
                        onRequest: handleAppleRequest,
                        onCompletion: { result in
                            handleAppleSignIn(result) { success in
                                if success {
                                    appState = .Onboarding
                                }
                            }
                        }
                    )
                    .signInWithAppleButtonStyle(.black)
                    .frame(width: 180, height: 42)
                }
            }
            .scaleEffect(x: 1.8, y: 1.8)
            
            Spacer()
            
        }.background(
            Image("light-background")
                .resizable()
                .frame(width: 900, height: 1600)
                .ignoresSafeArea()
        )
    }
}


#Preview {
    LoginScreen(appState: .constant(.Login))
}
