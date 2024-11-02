// The Swift Programming Language
// https://docs.swift.org/swift-book

import Adwaita

@main
struct TLDR: App {

    let id = "io.github.neutrino2211.TLDR"
    var app: GTUIApp!

    @State("first-run", folder: "io.github.neutrino2211.TLDR/first-run") private var firstRun = true

    var scene: Scene {
        if firstRun {
		    	Window(id: "first-run") { window in
		    		FirstRunView(app: app, window: window, onCompleteCallback: {
						firstRun = false
						app.showWindow("main")
					})
		    }
		    .defaultSize(width: 480, height: 600)
        } else {
        		Window(id: "main") { window in
				MainView(app: app, window: window)
				.frame(minWidth: 400, minHeight: 600)
        		}
        		.defaultSize(width: 480, height: 600)
        }
    }
}
