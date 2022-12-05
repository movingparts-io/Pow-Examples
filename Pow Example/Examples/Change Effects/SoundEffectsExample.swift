import Pow
import SwiftUI

struct SoundEffectExample: View, Example {
    var body: some View {
        // All `SoundEffects` used here can be found in the
        // `Pow Example/Sounds/` folder and are free to use with any licensed
        // copy of Pow.
        ScrollView {
            VStack {
                Group {
                    GroupBox("Errors") {
                        HStack {
                            SoundEffectPad("Not Found", SoundEffect("notfound"))
                            SoundEffectPad("Pluck", SoundEffect("pluck"))
                            SoundEffectPad("Pong", SoundEffect("pong"))
                            SoundEffectPad("Ping", SoundEffect("ping"))
                        }
                    }

                    GroupBox("Undo") {
                        HStack {
                            SoundEffectPad("Brush", SoundEffect("brush"))
                            SoundEffectPad("Shake", SoundEffect("shake"))
                            SoundEffectPad("Swipe", SoundEffect("swipe"))
                            SoundEffectPad("Swish", SoundEffect("swish"))
                        }

                        HStack {
                            SoundEffectPad("Wip", SoundEffect("wip"))
                            SoundEffectPad("Whooop", SoundEffect("whop"))
                            SoundEffectPad("Detach", SoundEffect("detach"))
                            SoundEffectPad("Detach", SoundEffect("detach")).hidden()
                        }
                    }

                    GroupBox("Short") {
                        HStack {
                            SoundEffectPad("Boop", SoundEffect("boop"))
                            SoundEffectPad("Beep", SoundEffect("beep"))
                            SoundEffectPad("Biip", SoundEffect("biip"))
                            SoundEffectPad("Biip", SoundEffect("biip")).hidden()
                        }
                    }

                    GroupBox("Plopps") {
                        HStack {
                            SoundEffectPad("Plop", SoundEffect("plop"))
                            SoundEffectPad("Pop", SoundEffect("pop1", "pop2", "pop3", "pop4", "pop5"))
                            SoundEffectPad("Pop", SoundEffect("pop1")).hidden()
                            SoundEffectPad("Pop", SoundEffect("pop1")).hidden()
                        }
                    }
                }

                GroupBox("Drips") {
                    HStack {
                        SoundEffectPad("Drip", SoundEffect("drip"))
                        SoundEffectPad("Drip\nFlat", SoundEffect("drip.flat"))
                        SoundEffectPad("Drip\nRising", SoundEffect("drip.rising"))
                        SoundEffectPad("Drip\nFalling", SoundEffect("drip.falling"))
                    }
                }

                GroupBox("Notifications") {
                    HStack {
                        SoundEffectPad("Chime", SoundEffect("chime"))
                        SoundEffectPad("Chime\nFlat", SoundEffect("chime.flat"))
                        SoundEffectPad("Chime\nRising", SoundEffect("chime.rising"))
                        SoundEffectPad("Chime\nFalling", SoundEffect("chime.falling"))
                    }
                    HStack {
                        SoundEffectPad("Pick", SoundEffect("pick"))
                        SoundEffectPad("Pick\nFlat", SoundEffect("pick.flat"))
                        SoundEffectPad("Pick\nRising", SoundEffect("pick.rising"))
                        SoundEffectPad("Pick\nFalling", SoundEffect("pick.falling"))
                    }
                }

                GroupBox("Tension/Release") {
                    HStack {
                        SoundEffectPad("Reel", SoundEffect("reel"))
                        SoundEffectPad("Reel\nFlat", SoundEffect("reel.flat"))
                        SoundEffectPad("Reel\nRising", SoundEffect("reel.rising"))
                        SoundEffectPad("Reel\nFalling", SoundEffect("reel.falling"))
                    }
                }

                GroupBox("Results") {
                    HStack {
                        SoundEffectPad("Sparkle", SoundEffect("sparkle"))
                        SoundEffectPad("Sparkle\nFlat", SoundEffect("sparkle.flat"))
                        SoundEffectPad("Sparkle\nRising", SoundEffect("sparkle.rising"))
                        SoundEffectPad("Sparkle\nFalling", SoundEffect("sparkle.falling"))
                    }
                }

                GroupBox("Metal") {
                    HStack {
                        SoundEffectPad("Latch", SoundEffect("latch1", "latch2", "latch3", "latch4"))
                        SoundEffectPad("Lock", SoundEffect("lock1", "lock2", "lock3", "lock4"))
                        SoundEffectPad("Snap", SoundEffect("snap"))
                        SoundEffectPad("Dial", SoundEffect("dial"))
                    }
                }

                GroupBox("Glas") {
                    HStack {
                        SoundEffectPad("Tink", SoundEffect("tink"))
                        SoundEffectPad("Zing", SoundEffect("zing"))
                        SoundEffectPad("Glass", SoundEffect("glass"))
                        SoundEffectPad("Tick", SoundEffect("tick"))
                    }
                }
            }
            .padding()
        }
        .buttonStyle(SoundEffectButtonStyle())
        .buttonStyle(.bordered)
    }

    static var description: some View {
        Text("""
        Triggers the playback of a sound.

        - Parameters:
            - `effect`: The `SoundEffect` to play back.
        """)
    }

    static let localPath = LocalPath()

    static var icon: Image? {
        Image(systemName: "speaker.wave.2")
    }
}

private struct SoundEffectPad: View {
    var name: String

    var effect: SoundEffect

    init(_ name: String, _ effect: SoundEffect) {
        self.name = name
        self.effect = effect
    }

    @State
    private var triggers = 0

    var body: some View {
        Button(name) {
            triggers += 1
        }
        .changeEffect(.feedback(effect), value: triggers)
    }
}

private struct SoundEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .font(.caption2)
            .padding(4)
            .foregroundStyle(.secondary)
            .background(.tertiary, in: RoundedRectangle(cornerRadius: 3, style: .continuous))
            .overlay {
                if configuration.isPressed {
                    Circle()
                        .fill(RadialGradient(colors: [.white, .white.opacity(0.0)], center: .center, startRadius: 0, endRadius: 30))
                        .opacity(0.5)
                }
            }
            .frame(height: 64)
    }
}

struct SoundEffectExample_Previews: PreviewProvider {
    static var previews: some View {
        SoundEffectExample()
    }
}
