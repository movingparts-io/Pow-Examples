import Pow
import SwiftUI

struct SwooshExample: View, Example {
    @State
    var isVisible: Bool = false

    var body: some View {
        ZStack {
            if isVisible {
                PlaceholderView()
                    .transition(.movingParts.swoosh)
            }
        }
        .defaultBackground()
        .onTapGesture {
            let animation: Animation

            if isVisible {
                animation = .easeIn
            } else {
                animation = .spring()
            }

            withAnimation(animation) {
                isVisible.toggle()
            }
        }
    }
}
