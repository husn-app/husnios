import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var user: User = User()
    
    func fetchUserProfile() {
        let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/profile")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                do {
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    guard let data = data else {
                        print("No data received")
                        return
                    }
                    
                    let user_json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    self.user = User(json: user_json)
                }
            }
        }
        task.resume()
    }
    
    func deleteUserProfile() {
        let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/delete_account")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                do {
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    guard let data = data else {
                        print("No data received")
                        return
                    }
                }
            }
        }
        task.resume()
    }
    
}
