// The Swift Programming Language
// https://docs.swift.org/swift-book

import Adwaita

@main
struct AdwaitaTemplate: App {

    let id = "io.github.neutrino2211.TLDR"
    var app: GTUIApp!

    @State("first-run", folder: "io.github.neutrino2211.TLDR/first-run") private var firstRun = true

    var scene: Scene {
        if firstRun {
		    	Window(id: "first-run") { window in
		    		FirstRun(app: app, window: window, onCompleteCallback: {
		    			print("Done")
		    			firstRun = false
		    			app.showWindow("main")
		    		})
					.valign(.center)
					.halign(.center)
					.topToolbar {
						HeaderBar
							.empty()
							.headerBarTitle {
								Text("")
							}
					}
		    }
		    .defaultSize(width: 450, height: 600)
        } else {
        		Window(id: "main") { window in
        			Text(Loc.helloWorld)
		            .padding()
		            .topToolbar {
		                ToolbarView(app: app, window: window)
		            }
        		}
        		.defaultSize(width: 450, height: 600)
        }
    }

}
