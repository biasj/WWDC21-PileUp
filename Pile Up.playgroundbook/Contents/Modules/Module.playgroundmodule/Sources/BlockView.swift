
import SwiftUI

public struct BlockView: View {
    var block: Block
    
    // drag and drop gesture
    @State var dragState = DragState.unknown
    @State var dragAmount = CGSize.zero
    
    var onChanged: ((CGPoint, Block)  -> DragState)?
    var onEnded: ((CGPoint, Int, Block) -> Void)?
    
    init(block: Block, onChanged: @escaping ((CGPoint, Block) -> DragState), onEnded: @escaping((CGPoint, Int, Block) -> Void)) {
        self.block = block
        self.onChanged = onChanged
        self.onEnded = onEnded
    }
    
    public var body: some View {
        ZStack {
            // placeholder to keep block in place
            RoundedRectangle(cornerRadius: 10).frame(width: 164, height: 88, alignment: .center).foregroundColor(.clear)
            
            if !block.isDisabled {
                ZStack {
                    Image(uiImage: UIImage(named: "\(block.imageName)")!)
                        .resizable()
                        .frame(width: 150, height: 75, alignment: .center)
                    PileView(block: block)
                }
            }
        }
        .offset(dragAmount)
        .zIndex(dragAmount == .zero ? 0 : 1)
        .shadow(color: dragColor, radius: dragAmount == .zero ? 0 : 10)
        .shadow(color: dragColor, radius: dragAmount == .zero ? 0 : 10)
        // allows to drag the block
        .gesture(
            DragGesture(coordinateSpace: .named("Board"))
                .onChanged {
                    self.dragAmount = $0.translation
                    self.dragState = onChanged?($0.location, self.block) ?? .unknown
                }
                .onEnded { 
                    if self.dragState == .good {
                        self.onEnded?($0.location, self.block.index, self.block)
                    }
                    //                      print("dragAmount: \(dragAmount)")
                    self.dragAmount = .zero
                }
            
        )
    }
    
    var dragColor: Color {
        switch dragState {
        case .unknown:
            return .black
        case .good:
            return .green
        case .bad: 
            return .red
        }
    }
}

