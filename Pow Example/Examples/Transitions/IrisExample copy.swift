import Pow
import SwiftUI

struct IrisExample: View, Example {
    @State
    var isVisible: Bool = false

    var body: some View {
        ZStack {
            if isVisible {
                PlaceholderView()
                    .compositingGroup()
                    .transition(.movingParts.iris(blurRadius: 10))
            }
        }
        .defaultBackground()
        .onTapGesture {
            withAnimation(.spring(dampingFraction: 1)) {
                isVisible.toggle()
            }
        }
    }
}
