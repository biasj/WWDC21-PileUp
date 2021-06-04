import SwiftUI

public struct GoalView: View {
    var goal: Goal
    
    public var body: some View {
        Image(uiImage: UIImage(named: "\(goal.imageName)")!)
            .resizable()
            .frame(width: 164, height: 88, alignment: .center)
    }
}
