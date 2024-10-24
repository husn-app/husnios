import SwiftUI

// Custom SearchBar view
struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    @Binding var isSearchCommited: Bool
    var body: some View {
        HStack {
            TextField("Search", text: $text, onEditingChanged: { isEditing in
                self.isEditing = isEditing
            }, onCommit : {
                self.isSearchCommited = true
            })
            .padding(10)
            .padding(.horizontal, 25)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(10)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                    
                }
            )
            .submitLabel(.search)  // Change the return key to display "Search"
            if self.isEditing {
                Button(action: {
                    self.text = ""
                    self.isEditing = false
                    
                    // Dismiss keyboard.
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal)
    }
}
