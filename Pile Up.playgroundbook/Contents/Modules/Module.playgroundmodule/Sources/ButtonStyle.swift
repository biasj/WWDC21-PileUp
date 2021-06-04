import SwiftUI

public struct GameButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label.frame(width: 200, height: 80, alignment: .center)
            .background(configuration.isPressed ? Color(.white).opacity(0.7) : Color(.customGray))
            .foregroundColor(.customPink)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.customPink, lineWidth: 3))
    }
}

public struct PageControlButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 150, height: 50, alignment: .center)
            .foregroundColor(configuration.isPressed ? Color(.customPink).opacity(0.6) : .customPink)
            .font(.system(size: 50, weight: .bold, design: .rounded))
    }
}
