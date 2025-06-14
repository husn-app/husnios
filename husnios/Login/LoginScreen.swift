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
        VStack (){
            Text("Husn")
                .font(.custom("Zapfino", size: 72))
                .foregroundColor(.black)
                .padding(.vertical, 0)

            VStack(spacing: 12) {
                Button(
                    action: {
                        handleSignInButton { success in
                            if success {
                                appState = .Onboarding
                            }
                        }
                    }
                ) {
                    HStack (spacing:0){
                        Image("google.icon.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44)
                        
                        Text("Sign in with Google")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.system(size: 22))
                    }
                    
                }
                .frame(width: 300, height: 60)
                .background(Color.black)
                .cornerRadius(8)
                
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
                .frame(width: 300, height: 60)
                
                Spacer()
            }
            
            
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
