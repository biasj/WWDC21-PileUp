import SwiftUI

public struct HelpPagesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selection = 0
    
    public var body: some View {
        VStack(spacing: 50) {
            ZStack {
                TabView(selection: $selection) {
                    HelpView(text: "Drag and drop blocks to move them around the board", videoName: "Drag and Drop").tag(0)
                    HelpView(text: "A block can only interact with its neighbors. Swap positions between blocks of different colors and pile up blocks of the same colors", videoName: "Neighbors").tag(1)
                    HelpView(text: "The goal is to pile all blocks of the same colors at the matching highlighted spot.\nHave fun!!", videoName: "Goal").tag(2)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .cornerRadius(10)
                .foregroundColor(.gray)
                
                HStack(spacing: 530) {
                    Button("<") {
                        if selection > 0 {
                            selection -= 1
                        }
                    }

                    Button(">") {
                        if selection < 2 {
                            selection += 1
                        }
                    }
                }.buttonStyle(PageControlButtonStyle())
            }

            Button("Play") {
                presentationMode.wrappedValue.dismiss()
            }.buttonStyle(GameButtonStyle())
        }
    }
    
}
