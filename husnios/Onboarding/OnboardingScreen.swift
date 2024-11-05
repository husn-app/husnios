import SwiftUI

struct OnboardingScreen: View {
    @State private var selectedGender: String = ""
    @State private var age: Int = 24
    @State private var genders: [String] = ["MAN", "WOMAN"]
    @Binding var appState: AppState
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack() {
                Text("Let's personalize your shopping experience!").font(.title3).padding()
                Spacer()
            }.padding(.horizontal, 0)
            Divider()
            
            HStack {
                ForEach($genders, id: \.self) { $gender in
                    Button(action: {
                        selectedGender = gender
                    }) {
                        VStack {
                            Circle()
                                .fill(colorScheme == ColorScheme.dark ? Color.white.opacity(0.70) : Color.black.opacity(0.05))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Circle()
                                        .stroke(selectedGender == gender ? Color.primary : Color.clear, lineWidth: 4)
                                )
                                .overlay(
                                    Image(gender == "MAN" ? "Man" : "Woman")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                )
                            Text(gender == "MAN" ? "Male" : "Female")
                                .fontWeight(selectedGender == gender ? .semibold : .regular)
                                .foregroundColor(selectedGender == gender ? Color.primary : Color(.systemGray))
                        }
                    }
                    .padding()
                }
            }
            .padding(.vertical, 32)
            
            HStack(spacing: 0) {
                Text("What's your age?").font(.title3)
                Spacer()
            }
            Text("\(age)").font(.title2)
                .padding(.top, 4)
            
            HStack(spacing : 20) {
                Stepper(value: $age, in: 12...72) {}
                    .frame(width:80)
                
                Slider(value: Binding(
                    get: { Double(age) },
                    set: { age = Int($0) }
                ), in: 12...72, step: 1)
                .padding(.horizontal, 0)
                .frame(maxWidth: .infinity)
            }
            

            HStack(alignment: .center , spacing : 8) {
                Image(systemName: "info.circle")
                    .foregroundColor(.gray)
                Text("Age and gender are required to show you fashion apparel and accessories that are relevant to you.")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.top, 40)
            
            Button(action: {
                submitOnboardingData(age: age, gender: selectedGender) { success in
                    if success {
                        appState = .Main
                    } else {
                        print("Failed to submit onboarding data")
                    }
                }
            }) {
                Text("Submit")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.primary)
                    .background(Color.primary.opacity(0.1))
                    .clipShape(Capsule())
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    OnboardingScreen(appState: .constant(.Onboarding))
}


func submitOnboardingData(age: Int, gender: String, completion: @escaping (Bool) -> Void) {
    guard verifyGenderAndAge(age: age, gender: gender) else {
        print("Invalid age or gender")
        completion(false)
        return
    }
    
    let url = URL(string: "\(Config.HUSN_SERVER_URL)/api/onboarding")
    
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let onboardingData: [String: Any] = [
        "gender": gender,
        "age": age
    ]
    
    guard let jsonData = try? JSONSerialization.data(withJSONObject: onboardingData) else {
        print("Failed to serialize JSON")
        completion(false)
        return
    }
    
    request.httpBody = jsonData
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            if let error = error {
                print("Error during submission: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response received")
                completion(false)
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(true)
            } else {
                print("Submission failed with status code: \(httpResponse.statusCode)")
                completion(false)
            }
        }
    }
    task.resume()
}

func verifyGenderAndAge(age: Int, gender: String) -> Bool {
    if gender != "MAN" && gender != "WOMAN" {
        return false
    }
    if age < 12 || age > 72 {
        return false
    }
    return true
}
