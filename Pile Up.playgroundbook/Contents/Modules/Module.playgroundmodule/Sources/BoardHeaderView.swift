import SwiftUI

public struct BoardHeaderView: View {
    @EnvironmentObject var puzzle: PuzzleGame
    @State var conclusionIsPresented = false
    @State var helpIsPresented = true
    
    public var body: some View {
        HStack(spacing: 25) {
            // high score view
            VStack(spacing: 15) {
                Text("High Score")
                Text("\(puzzle.getHighScore())")
            }.textStyle()
            
            // group button that disables restart button if game is over
            VStack(spacing: 20) {
                Button("Help") {
                    helpIsPresented.toggle()
                }.fullScreenCover(isPresented: $helpIsPresented) {
                    HelpPagesView().frame(width: 700, height: 700, alignment: .center)
                }
                
                ZStack { 
                    Button("Restart", action: resetGame)
                    if !puzzle.isPlaying {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.customGray.opacity(0.7))
                            .disabledButtonStyle()
                    }
                }
            }
            
            // group button that disables end game button if game is over
            VStack(spacing: 20) {
                Button("New Game", action: newGame)
                ZStack {
                    Button("End Game") {
                        endGame()
                        conclusionIsPresented.toggle()
                    }.sheet(isPresented: $conclusionIsPresented) {
                        ConclusionView().environmentObject(puzzle)
                    }
                    
                        // disables button
                    if !puzzle.isPlaying {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.customGray.opacity(0.7))
                            .disabledButtonStyle()
                    }
                }
            }
        }
        .buttonStyle(GameButtonStyle())
        .scaledToFill()
        .font(.system(size: 30, weight: .bold, design: .rounded))
    }
    
    func resetGame() {
        puzzle.resetGame()
    }
    
    func endGame() {
        puzzle.endGame()
    }
    
    func newGame() {
        puzzle.newGame()
    }
    
    func showHelp() {
        print("help")
    }
    
    func disableButton() {
        
    }
}

