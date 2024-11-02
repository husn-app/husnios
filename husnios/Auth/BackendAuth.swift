
import SwiftUI

func isAuthenticatedWithBackend(params: [String: Any], completion: @escaping (Bool) -> Void) {
    let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/applogin")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let jsonData = try? JSONSerialization.data(withJSONObject: params)
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
