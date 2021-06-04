import SwiftUI

// pile indicator in each block
public struct PileView: View {
    var block: Block
    @EnvironmentObject var puzzle: PuzzleGame
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(10), spacing: 5), count: 2)
    
    public var body: some View {
        LazyVGrid(columns: columns, spacing: 5) {
            ForEach(0..<(puzzle.getBlock(of: block.index).pile), id: \.self) { _ in
                // position grid following number of piles and colors
                switch puzzle.getBlock(of: block.index).pile {
                case 1:
                    switch block.color {
                    case .red:
                        // top left corner
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: -50, y: -20)
                    case .blue:
                        // top right corner
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: 75, y: -20)
                    case .yellow:
                        // bottom left corner
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: -50, y: 30)
                    case .green:
                        // bottom right corner
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: 75, y: 30)
                    }
                    
                case 2:
                    switch block.color {
                    case .red:
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: -50, y: -20)
                    case .blue:
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: 60, y: -20)
                    case .yellow:
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: -50, y: 30)
                    case .green:
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: 60, y: 30)
                    }
                    
                case 3, 4:
                    switch block.color {
                    case .red:
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: -50, y: -12)
                    case .blue:
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: 60, y: -12)
                    case .yellow:
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: -50, y: 22)
                    case .green:
                        Circle().frame(width: 10, height: 10, alignment: .center).position(x: 60, y: 22)
                    }
                    
                default: Circle().frame(width: 10, height: 10, alignment: .center).position(x: -50, y: -15)
                }
                
            }.foregroundColor(.white)
        }
    }
}

