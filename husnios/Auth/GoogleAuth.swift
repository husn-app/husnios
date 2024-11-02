import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

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
            isAuthenticatedWithBackend(params:["idToken": idToken]) { isAuthenticated in
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

func checkIfUserIsLoggedIn(completion: @escaping (Bool) -> Void) {
    if let cookies = HTTPCookieStorage.shared.cookies {
        for cookie in cookies {
            if cookie.name == "auth_info" {
                if (cookie.value.isEmpty) {
                    completion(false)
                    return
                    
                }
                
                completion(true)
                return
            }
        }
    }
    print("auth_info cookie doesn't exist. Logging out...")
    LogoutAndClearCookies()
    completion(false)
}
