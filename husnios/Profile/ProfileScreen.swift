import SwiftUI

struct ProfileScreen: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showAlert = false
    @State private var deleteConfirmation = ""
    
    var body: some View {
        VStack(spacing: 20) {
            if !viewModel.user.picture_url.isEmpty, let url = URL(string: viewModel.user.picture_url) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }
            
            Text("\(viewModel.user.given_name) \(viewModel.user.family_name)")
                .font(.title)
                .fontWeight(.bold)
            
            Text(viewModel.user.email)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button(action: {
                showAlert = true
            }) {
                Text("Delete Account")
                    .foregroundColor(.red)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Account"),
                    message: Text("This action is irreversible and will PERMANENTLY DELETE your account and any associated data.\n\nAre you sure you want to do this?"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(Text("Delete")) {  viewModel.deleteUserProfile()
                        LogoutAndClearCookies()
                        if let window = UIApplication.shared.windows.first {
                            window.rootViewController = UIHostingController(rootView: ContentView())
                            window.makeKeyAndVisible()
                        }
                    }
                )
            }
        }
        .padding()
        .navigationTitle("Profile")
        .onAppear {
             viewModel.fetchUserProfile()
//            viewModel.user = User(given_name: "John", family_name: "Doe", picture_url: "", email: "john.doe@example.com", is_private_email: false)
        }
    }
}

#Preview {
    ProfileScreen()
}
