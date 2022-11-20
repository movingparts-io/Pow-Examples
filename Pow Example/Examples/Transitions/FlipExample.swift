import Pow
import SwiftUI

struct FlipExample: View, Example {
    @State
    var isVisible: Bool = false

    var body: some View {
        ZStack {
            if isVisible {
                PlaceholderView()
                    .transition(.movingParts.flip)
            }
        }
        .defaultBackground()
        .onTapGesture {
            let animation: Animation

            if isVisible {
                animation = .easeIn
            } else {
                animation = .interactiveSpring(response: 0.4, dampingFraction: 0.4, blendDuration: 2.45)
            }

            withAnimation(animation) {
                isVisible.toggle()
            }
        }
    }
}
