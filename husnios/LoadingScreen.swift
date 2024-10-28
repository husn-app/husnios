import SwiftUI

struct LoadingScreen: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Image("AppIconImage")
                .resizable()
                .frame(width: 172, height: 172)
        }
    }
}

#Preview {
    LoadingScreen()
}
