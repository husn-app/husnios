import SwiftUI
import GoogleSignIn

struct ProfilePic : View {
    var body: some View {
        if let pictureUrlString = HTTPCookieStorage.shared.cookies?.first(where: { $0.name == "picture_url" })?.value,
           let pictureUrl = URL(string: pictureUrlString) {
            AsyncImage(url: pictureUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(width: 40, height: 40)
            }
        } else {
            // Handle the case where the URL is not available
            Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
        }
    }
}
struct TopNavbar: View {
    @State private var showLogoutAlert = false
    
    var body: some View {
        
        // Top bar with app title and profile picture
        HStack {
            Text("Husn")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            Menu {
                Button(action: {
                    showLogoutAlert = true
                }) {
                    Text("Logout")
                }
            } label: {
                ProfilePic()
            }
        }
        .padding(.top, 0)
        .padding(.horizontal)
        .padding(.bottom, 8)
        .alert(isPresented: $showLogoutAlert) {
            Alert(
                title: Text("Logout"),
                message: Text("Are you sure you want to logout?"),
                primaryButton: .destructive(Text("Logout")) {
                    GIDSignIn.sharedInstance.signOut()
                    if let cookies = HTTPCookieStorage.shared.cookies {
                        for cookie in cookies {
                            HTTPCookieStorage.shared.deleteCookie(cookie)
                        }
                    }
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: ContentView())
                        window.makeKeyAndVisible()
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}
