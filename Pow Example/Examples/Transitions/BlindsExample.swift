import Pow
import SwiftUI

struct BlindsExample: View, Example {
    @State
    var isVisible: Bool = false

    var body: some View {
        ZStack {
            if isVisible {
                PlaceholderView()
                    .transition(.movingParts.blinds)
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
