import SwiftUI

extension View {
    func textStyle() -> some View {
        self
            .font(.system(size: 36, weight: .bold, design: .rounded))
            .frame(width: 300, height: 180, alignment: .center)
            .foregroundColor(.customPink)
            .background(Color.customGray)
            .cornerRadius(10)
    }
    
    func disabledButtonStyle() -> some View {
        self
            .frame(width: 200, height: 80, alignment: .center)
            .allowsHitTesting(true)
    }
}

