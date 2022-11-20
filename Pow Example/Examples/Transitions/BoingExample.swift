import Pow
import SwiftUI

struct BoingExample: View, Example {
    @State
    var isVisible: Bool = false

    var body: some View {
        HStack {
            if isVisible {
                let defaultSpring = Animation.spring()

                PlaceholderView()
                    .frame(maxWidth: 120, maxHeight: 120)
                    .transition(.movingParts.boing(edge: .top).animation(defaultSpring))

                let mediumSpring = Animation.interactiveSpring(dampingFraction: 0.5)

                PlaceholderView()
                    .frame(maxWidth: 120, maxHeight: 120)
                    .transition(.movingParts.boing(edge: .top).animation(mediumSpring))

                let looseSpring = Animation.interpolatingSpring(stiffness: 100, damping: 8)

                PlaceholderView()
                    .frame(maxWidth: 120, maxHeight: 120)
                    .transition(.movingParts.boing(edge: .top).animation(looseSpring))
            }
        }
        .defaultBackground()
        .onTapGesture {
            withAnimation {
                isVisible.toggle()
            }
        }
    }
}
