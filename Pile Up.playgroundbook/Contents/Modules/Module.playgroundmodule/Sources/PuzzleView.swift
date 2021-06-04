import SwiftUI

public struct PuzzleView: View {
    @EnvironmentObject var puzzle: PuzzleGame
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 20) {
                BoardHeaderView()
                BoardView()
                    .coordinateSpace(name: "Board")
            }
    }
}

