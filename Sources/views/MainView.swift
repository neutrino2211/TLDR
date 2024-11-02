import Adwaita
import Foundation

enum ViewStatus {
	case input
	case query
	case error
	case processing
}

struct MainView : View {
	var app: GTUIApp
    var window: GTUIApplicationWindow

	@State var showAbout: Bool = false
	@State var showPreferences: Bool = false
	@State private var query: String = ""
	@State private var progress: Double = 0.0

	@State("searchEngineOptions", forceUpdates: false) private var searchSettings: SearchEngineSettings = .init()
	@State("aiProviderOptions", forceUpdates: false) private var aiSettings: AIProviderSettings = .init()

   	@State private var status: ViewStatus = .input

	var view: Body {
		VStack {
			switch status {
				case .input:
					Box {
						Image(icon: .default(icon: .systemSearch), size: 64)
						Text("Waiting for a search")
						.style("title-1")
					}
					.style("dim-label")
				case .query:
					SearchView(app: app, window: window, queryProgress: progress)
				case .error:
					Text("An error occured")
					.style("title-1")
				case .processing:
					Text("Processing")
					.style("title-1")
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
        				let engine: SearchEngine = searchEnginesMap[searchSettings.engine]!
        				print(engine.query(text))
        				let request: Request = .init(url: engine.query(text))
					let task = request.task { (data, response, error) in
						print(data as Any, response as Any, error as Any)
						if data == nil {return}
						let str = String(decoding: data!, as: UTF8.self)
						let links = parseLinks(str)
						print(links)
					}

					task.resume()
        				print(text)
					print(aiSettings)

        				query = text
        				status = .processing
        			}
		    		.padding()
		    		.hexpand(true)
        		}
        }
	}
}