import SwiftUI

protocol Example: View {
    associatedtype Description: View

    init()

    @ViewBuilder
    static var description: Description { get }

    static var icon: Image? { get }

    static var localPath: LocalPath { get }
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
    static var navigationLink: NavigationLink<some View, some View> {
        NavigationLink {
            ZStack {
                Self()
                    .background()
                    .toolbar {
                        GithubButton(Self.localPath)

                        if type(of: Self.description) != EmptyView.self {
                            InfoButton(type: Self.self)
                        }
                    }
                    .navigationTitle(title)
            }
        } label: {
            let colors = [Color.red, .orange, .yellow, .green, .blue, .indigo, .purple, .mint]

            var rng = MinimalPCG(string: title)

            Label {
                Text(title)
            } icon: {
                IconView {
                    icon ?? Image(systemName: "wand.and.stars.inverse")
                }
                .foregroundStyle(colors[Int(rng.next()) % colors.count].gradient)
            }
        }
    }

    static var icon: Image? { nil }

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

    func autotoggle(_ binding: Binding<Bool>, with animation: Animation = .default) -> some View {
        self
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(animation) {
                        binding.wrappedValue = true
                    }
                }
            }
    }
}

struct IconView<Content: View>: View {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    @Environment(\.colorScheme)
    var colorScheme

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.primary)
                .aspectRatio(1, contentMode: .fill)
                .frame(width: 28, height: 28)
                .brightness(colorScheme == .dark ? -0.2 : -0.03)

            content
                .foregroundStyle(.white)
        }
        .font(.system(size: 18))
        .imageScale(.small)
        .symbolRenderingMode(.monochrome)
        .symbolVariant(.fill)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .strokeBorder(.white.opacity(0.1), lineWidth: 0.5)
                .blendMode(.plusLighter)
        }
    }
}

struct LocalPath {
    var path: String

    init(path: String = #file) {
        self.path = path
    }

    var url: URL {
        URL(fileURLWithPath: path)
    }
}

// *Really* minimal PCG32 code / (c) 2014 M.E. O'Neill / pcg-random.org
// Licensed under Apache License 2.0 (NO WARRANTY, etc. see website)
//
// Ported from https://www.pcg-random.org/download.html
private struct MinimalPCG {
    var state: UInt64

    var inc: UInt64

    init(string: String) {
        self.state = string.utf8.reduce(0.0) { a, b in a + (Double(b) * .pi) }.bitPattern
        self.inc = (Double(string.count) * .pi).bitPattern
    }

    init(state: UInt64, inc: UInt64) {
        self.state = state
        self.inc = inc
    }

    mutating func next() -> UInt32 {
        let oldstate = state

        // Advance internal state
        state = oldstate &* 6364136223846793005 &+ (inc | 1)
        // Calculate output function (XSH RR), uses old state for max ILP
        let xorshifted = ((oldstate >> 18) ^ oldstate) >> 27
        let rot = Int(truncatingIfNeeded: oldstate >> 59)

        return UInt32(truncatingIfNeeded: (xorshifted >> rot) | (xorshifted << ((-rot) & 31)))
    }
}
