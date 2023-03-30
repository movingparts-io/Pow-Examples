import SwiftUI

#if os(iOS)
import MessageUI
#endif

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("This is the official example app for Pow, the Surprise and Delight framework for SwiftUI.")

            Text("Tap the individual examples to see the effects and transitions in action.")

            Text("**Note:** While this app requires iOS 16, Pow itself supports iOS 15 and above.")
        }
        #if os(iOS)
        .font(.subheadline.leading(.loose))
        #endif
        .foregroundColor(.primary)

        Link(destination: URL(string: "https://movingparts.io/pow")!) {
            ViewThatFits {
                Label("Pow Website and Licensing Options", systemImage: "safari")
                Label("Pow Website & Licensing Options", systemImage: "safari")
                Label("Pow Website & Licensing", systemImage: "safari")
                Label("Pow Website", systemImage: "safari")
            }
        }

        Link(destination: URL(string: "https://github.com/movingparts-io/Pow-Examples")!) {
            ViewThatFits {
                Label("GitHub Repository for this App", systemImage: "terminal")
                Label("GitHub Repo for this App", systemImage: "terminal")
                Label("Repo for this App", systemImage: "terminal")
            }
        }

        #if os(iOS)
        if MFMailComposeViewController.canSendMail() {
            Link(destination: URL(string: "mailto:hello@movingparts.io")!) {
                Label("Support", systemImage: "envelope")
            }
        }
        #endif
    }
}

struct DecoratedAboutView: View {
    var body: some View {
        GroupBox {
            VStack(alignment: .leading) {
                AboutView()
                    .fixedSize()
            }
            .padding()
        }
    }
}
