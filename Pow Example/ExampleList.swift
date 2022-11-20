import SwiftUI

struct ExampleList: View {
    var body: some View {
        List {
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
        .navigationTitle("Examples")
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
        ExampleList()
    }
}
