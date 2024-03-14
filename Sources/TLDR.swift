// The Swift Programming Language
// https://docs.swift.org/swift-book

import Adwaita

@main
struct TLDR: App {
	
	let id = "io.github.neutrino2211.TLDR"
	var app: GTUIApp!
	
	@State("TLDR.first_run") private var firstRun = true;
	
	@State private var progressString = ""
	@State private var installingOllama = false

	var scene: Scene {
		Window(id: "main") { window in
			if firstRun {
				HeaderBar.empty()

				FirstRunView()
			} else {
				Text("Hello, World!")
					.style("title-1")
					.padding()
					.topToolbar {
						Toolbar(app: app, window: window)
					}
			}
		}
		.defaultSize(width: 480, height: 640)
		.keyboardShortcut("q".ctrl(), action: { window in
			window.close()
		})
	}
}
