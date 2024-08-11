import Adwaita

struct MainView : View {
	var app: GTUIApp
    var window: GTUIApplicationWindow

	@State var showAbout: Bool = false
	@State var showPreferences: Bool = false
	@State private var query: String = ""

	var view: Body {
		VStack {
			if query.count > 0 {
				SearchView(app: app, window: window)
			} else {
				Box {
					Image(icon: .default(icon: .systemSearch), size: 64)
					Text("Waiting for a search")
					.style("title-1")
				}
				.style("dim-label")
			}
		}
		.valign(.center)
        .topToolbar {
            ToolbarView(app: app, window: window, showAbout: $showAbout, showPreferences: $showPreferences)
            .aboutDialog(
            		visible: $showAbout,
            		app: "TLDR",
            		developer: "Mainasara Al-amin Tsowa",
            		version: "0.0.0-alpha",
            		icon: .custom(name: "io.github.neutrino2211.TLDR"),
            		website: .init(string: "https://github.com/neutrino2211/TLDR"),
            		issues: .init(string: "https://github.com/neutrino2211/TLDR/issues")
            	)
            	.dialog(visible: $showPreferences) {
            		PreferencesView(app: app, window: window)
            	}
        }
        .bottomToolbar {
        		HStack {
        			Entry(placeholder: "Search")
        			.icon(.default(icon: .systemSearch))
        			.onSubmit { text in
        				print(text)
        				query = text
        			}
		    		.padding()
		    		.hexpand(true)
        		}
        }
	}
}