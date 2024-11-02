import AuthenticationServices

func handleAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
    request.requestedScopes = [.email, .fullName]
}

func handleAppleSignIn(_ result: Result<ASAuthorization, Error>, completion: @escaping (Bool) -> Void) {
    print("handle APPle SignIn")
    switch result {
    case .success(let authorization):
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let idToken = appleIDCredential.identityToken
            guard let idTokenString = String(data: idToken!, encoding: .utf8) else { return }
            
            // Send the idToken to backend for verification
            isAuthenticatedWithBackend(params: [
                "idToken": idTokenString,
                "sign_in_type" : "APPLE",
                "given_name" : appleIDCredential.fullName?.givenName ?? "",
                "family_name" : appleIDCredential.fullName?.familyName ?? ""],
                                       completion: completion)
        }
    case .failure(let error):
        print("Error signing in with Apple: \(error)")
        completion(false)
    }
}
