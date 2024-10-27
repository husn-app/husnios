import GoogleSignInSwift
import GoogleSignIn
import SwiftUI

// TODO: This is okay for first time users. For users who are registered
// and try to login, it'll take them to onboarding and then quickly to MainScreen
// This is okay but for now but can be later fixed by keeping state variables isOnboarded/isLoggedIn
// in ContentView along with appState
struct LoginScreen: View {
    @Binding var appState: AppState
    @Environment(\.colorScheme) var colorScheme

    var body: some View {

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
            })
        }.background(Color(.systemBackground))
            .frame(width: 200)
    }
}

func handleSignInButton(completion: @escaping (Bool) -> Void) {
    guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
        // Handle the error when rootViewController is not available
        completion(false)
        return
    }
    
    GIDSignIn.sharedInstance.signIn( withPresenting: rootViewController) { signInResult, error in
        if let error = error {
            print("Error during sign in: \(error.localizedDescription)")
            completion(false)
            return
        }
        
        guard let result = signInResult else {
            print("Sign in result is nil")
            completion(false)
            return
        }
        
        // If sign in succeeded, authenticate with backend
        print("Sign in succeeded: \(result)")
        if let idToken = result.user.idToken?.tokenString {
            isAuthenticatedWithBackend(idToken: idToken) { isAuthenticated in
                if !isAuthenticated {
                    GIDSignIn.sharedInstance.signOut()
                }
                completion(isAuthenticated)
            }
        } else {
            completion(false)
        }
    }
}

func isAuthenticatedWithBackend(idToken: String, completion: @escaping (Bool) -> Void) {
    let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/applogin")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let jsonData = try? JSONSerialization.data(withJSONObject: ["idToken": idToken])
    request.httpBody = jsonData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            do {
                if let error = error {
                    print(error)
                    completion(false)
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    completion(false)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    completion(json["is_logged_in"] as! Bool)
                } catch {
                    print("Failed to parse JSON")
                    print("Data received: \(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")")
                    completion(false)
                }
            }
        }
    }
    task.resume()
}


#Preview {
    LoginScreen(appState: .constant(.Login))
}
