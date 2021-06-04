import SwiftUI

public struct BoardView: View {
    @EnvironmentObject var puzzle: PuzzleGame
    @State var blockFrames = [CGRect](repeating: .zero, count: 16)
    @State var conclusionIsPresented = false
    
    private let columns: [GridItem] = Array(repeating: .init(.fixed(160), spacing: 15), count: 4)
    
    public init() { }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // grid background
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 750, height: 450, alignment: .center)
                    .foregroundColor(Color.customGray)
                
                // grid background
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(0..<puzzle.getBlocks().count) { i in
                        BlockBackgroundView(i: i)
                            .overlay(
                                GeometryReader { geo in
                                    Color.clear
                                        .onAppear {
                                            self.blockFrames[i] = geo.frame(in: .named("Board"))
                                        }
                                }
                            )
                    }
                }
                
                // block grid
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(0..<puzzle.getBlocks().count) { i in
                        BlockView(block: puzzle.getBlock(of: i), onChanged: self.blockMoved, onEnded: self.blockDropped)
                    }
                }
                
            }
            
        }.frame(width: 750, height: 450, alignment: .center)
        .sheet(isPresented: $conclusionIsPresented) {
            ConclusionView().environmentObject(puzzle)
        }
    }
    
    func blockMoved(location: CGPoint, block: Block) -> DragState {
        if let match = blockFrames.firstIndex(where: { $0.contains(location) }) {
            // check if the drop zone is the neighbor
            if match == block.index {
                return .unknown
            } else if puzzle.isNeighbor(block: block, index: match) && !puzzle.isBlockDisabled(at: match) {
                return .good
            } else {
                return .bad
            }
        }
        return .unknown
    }
    
    func blockDropped(location: CGPoint, from blockIndex: Int, block: Block) {
        // the position of where it was dropped on
        if let dropIndex = blockFrames.firstIndex(where: {$0.contains(location)} ) {
            if puzzle.shouldDropBlock(at: dropIndex, block: block){
                // if they have the same images, pile
                if puzzle.haveSameImages(at: dropIndex, block: block) {
                    // disables block that was dragged
                    puzzle.disableBlock(at: blockIndex)
                    puzzle.pileBlock(at: dropIndex, from: block)
                    
                    if puzzle.isSolved() {
                        puzzle.endGame()
                        conclusionIsPresented.toggle()
                    }
                    
                } else {
                    // swap block and puzzle.dropIndex
                    puzzle.swapBlocks(from: block, to: dropIndex)
                }
            }
        }
    }
    
}

