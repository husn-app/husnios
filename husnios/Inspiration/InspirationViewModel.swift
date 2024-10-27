import Foundation
import Combine

class InspirationViewModel: ObservableObject {
    @Published var inspirations: [Inspiration] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchInspirations() {
        let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/inspiration")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
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
                    
                    let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let inspirationsJson = json["inspirations"] as! [[String: Any]]
                    self.inspirations = inspirationsJson.map { Inspiration(json: $0) }
                }
            }
        }
        task.resume()
    }
}
