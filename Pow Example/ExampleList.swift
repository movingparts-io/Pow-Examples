import Pow
import MessageUI
import SwiftUI

struct ExampleList: View {
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text("This is the official example app for Pow, the Surprise and Delight framework for SwiftUI.")

                    Text("Tap the individual examples to see the effects and transitions in action.")
                }
                .font(.body.leading(.loose))
                .foregroundColor(.secondary)

                Link(destination: URL(string: "https://movingparts.io/pow")!) {
                    Label("Pow Website", systemImage: "safari")
                }

                Link(destination: URL(string: "https://github.com/movingparts-io/Pow-Examples")!) {
                    ViewThatFits {
                        Label("GitHub Repository for this App", systemImage: "terminal")
                        Label("GitHub Repo for this App", systemImage: "terminal")
                        Label("Repo for this App", systemImage: "terminal")
                    }
                }

                if MFMailComposeViewController.canSendMail() {
                    Link(destination: URL(string: "mailto:hello@movingparts.io")!) {
                        Label("Support", systemImage: "envelope")
                    }
                }
            }

            Section  {
                SocialFeedExample.navigationLink
            } header: {
                Label("Screens", systemImage: "iphone")
            } footer: {
                Text("Pre-composed screens that show how to use Pow in context. Use them as inspiration for your app.")
            }

            Section  {
                JumpExample.navigationLink
                PingExample.navigationLink
                RiseExample.navigationLink
                ShakeExample.navigationLink
                ShineExample.navigationLink
                SpinExample.navigationLink
                SprayExample.navigationLink
            } header: {
                Label("Change Effects", systemImage: "sparkles")
            } footer: {
                Text("Change effects can be triggered whenever a value changes.")
            }

            Section {
                Group {
                    AnvilExample.navigationLink
                    BlindsExample.navigationLink
                    BlurExample.navigationLink
                    BoingExample.navigationLink
                    ClockExample.navigationLink
                    FilmExposureExample.navigationLink
                    FlickerExample.navigationLink
                    FlipExample.navigationLink
                    GlareExample.navigationLink
                }
                Group {
                    IrisExample.navigationLink
                    MoveExample.navigationLink
                    PoofExample.navigationLink
                    PopExample.navigationLink
                    SkidExample.navigationLink
                    SnapshotExample.navigationLink
                    SwooshExample.navigationLink
                    VanishExample.navigationLink
                    WipeExample.navigationLink
                }
            } header: {
                Label("Transitions", systemImage: "arrow.forward.square")
            } footer: {
                Text("Transitions use the existing SwiftUI `.transition(_:)` API.")
            }
        }
        .navigationTitle("Pow Examples")
    }
}

struct PresentInfoAction {
    var action: (any Example.Type) -> ()

    init(action: @escaping (any Example.Type) -> Void) {
        self.action = action
    }

    func callAsFunction<T: Example>(_ type: T.Type) {
        action(type)
    }
}

extension EnvironmentValues {
    struct PresentInfoActionKey: EnvironmentKey {
        static var defaultValue: PresentInfoAction? = nil
    }

    var presentInfoAction: PresentInfoAction? {
        get { self[PresentInfoActionKey.self] }
        set { self[PresentInfoActionKey.self] = newValue }
    }
}

struct InfoButton<T: Example>: View {
    var type: T.Type

    @Environment(\.presentInfoAction)
    var presentInfoAction

    var body: some View {
        if let presentInfoAction {
            Button {
                presentInfoAction(type)
            } label: {
                Label("About", systemImage: "info.circle")
            }
        }
    }
}

struct ExampleList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExampleList()
        }
    }
}
