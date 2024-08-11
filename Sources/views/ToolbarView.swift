import Adwaita

struct ToolbarView: View {

    var app: GTUIApp
    var window: GTUIApplicationWindow
    var showAbout: Binding<Bool>
    var showPreferences: Binding<Bool>

    var view: Body {
        HeaderBar.end {
            Menu(icon: .default(icon: .openMenu), app: app, window: window) {
                MenuButton(Loc.preferences, window: false) {
                    showPreferences.wrappedValue.toggle()
                }
                .keyboardShortcut("p".ctrl())
                MenuButton(Loc.about) {
                		showAbout.wrappedValue.toggle()
                }
                MenuSection {
                    MenuButton(Loc.quit, window: false) {
                        app.quit()
                    }
                    .keyboardShortcut("q".ctrl())
                }
            }
            .primary()
            .tooltip("Main Menu")
        }
    }

}
