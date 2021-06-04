import SwiftUI
import PlaygroundSupport

public struct ContentView: View {
    @EnvironmentObject var puzzle: PuzzleGame
    
    public init() { }
    
    public var body: some View {
        PuzzleView().environmentObject(puzzle)
    }
}
