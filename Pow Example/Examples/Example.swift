import SwiftUI

protocol Example: View {
    associatedtype Description: View

    init()

    @ViewBuilder
    static var description: Description { get }
}

extension Example {
    static var title: String {
        String(describing: type(of: self))
            .replacingOccurrences(of: "Example.Type", with: "")
            .reduce(into: "") { string, character in
                if string.last?.isUppercase == false && character.isUppercase {
                    string.append(" ")
                }

                string.append(character)
            }
    }

    @ViewBuilder
    static var navigationLink: NavigationLink<Text, some View> {
        NavigationLink {
            ZStack {
                Self()
                    .background()
                    .toolbar {
                        if type(of: Self.description) != EmptyView.self {
                            InfoButton(type: Self.self)
                        }
                    }
                    .navigationTitle(title)
            }
        } label: {
            Text(title)
        }
    }

    static var description: some View {
        EmptyView()
    }

    static var erasedDescription: AnyView {
        AnyView(description)
    }
}

extension View {
    func defaultBackground() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Rectangle().fill(.background).ignoresSafeArea())
            .contentShape(Rectangle())
    }
}
