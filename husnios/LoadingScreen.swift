import SwiftUI

struct LoadingScreen: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(.gray.opacity(0.2))
                    .frame(width: 120, height: 120)
                
                Circle()
                    .trim(from: 0, to: 0.8)
                    .stroke(AngularGradient(gradient: Gradient(colors: [Color(.systemGray), .clear]), center: .center), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .frame(width: 240, height: 240)
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                    .onAppear {
                        isAnimating = true
                    }
                
                Image("AppIconImage") // Assuming "AppIcon" is the name of your app's icon asset
                    .resizable()
                    .frame(width: 172, height: 172)
            }
        }
    }
}

#Preview {
    LoadingScreen()
}
