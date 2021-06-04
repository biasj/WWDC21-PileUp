import SwiftUI

public struct ConclusionView: View {
    @EnvironmentObject var puzzle: PuzzleGame
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    public var body: some View {
        VStack(spacing: 50) {
            Image(uiImage: #imageLiteral(resourceName: "logo.png"))
                // shows specific messages in case of solved puzzle and unsolved puzzle
            if puzzle.isSolved() {
                if puzzle.isMovesRecordCopy {
                    Text(getHighScoreMessage()[0])
                    Text(getHighScoreMessage()[1])
                }
                else {
                    Text("Congratulations!!!")
                    Text("You solved the puzzle in \(puzzle.getMoves()) moves")
                }
            } else {
                Text(puzzle.getPuzzleUnsolvedMessage())
            }
            
            Text("Score: \(puzzle.getScore())")
            
            Button("Play again") {
                puzzle.resetGame()
                presentationMode.wrappedValue.dismiss()
            }.foregroundColor(.customPink)
            
            Button("New Game") {
                puzzle.newGame()
                presentationMode.wrappedValue.dismiss()
            }.foregroundColor(.customPink)
            
        }.padding()
        .foregroundColor(colorScheme == .dark ? .white : .gray)
        .font(.system(size: 30, weight: .bold, design: .rounded))
        
    }
    
    func getHighScoreMessage() -> [String] {
        return puzzle.getHighScoreMessage(moves: puzzle.getMoves())
    }
}

