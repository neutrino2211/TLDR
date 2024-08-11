import Adwaita
import CAdw

struct FirstRunView : View {
	var app: GTUIApp
    var window: GTUIApplicationWindow
    var onCompleteCallback: () -> Void

    @State private var progressString = ""
    @State private var progress = 0.0

    var view: Body {
    		VStack {
    			Image(icon: .custom(name: "io.github.neutrino2211.TLDR"), size: 128)
    				.padding(40)

    			Text(Loc.welcome)
				.padding(10)
				.style("title-1")

			Text(Loc.tagline)
				.padding(5)

			HStack {
				Button("Cancel") {
					print("Cancel clicked")
					app.quit()
				}
				.style("destructive-action")
				.hexpand(true)
				.padding(15)

				Button(
					progress > 0 ? "Installing Ollama" : "Install Ollama",
					icon: .custom(name: "com.ollama.logo-symbolic")
				) {
					print("Install Ollama Clicked")

					if progress == 0 {
						OllamaCommandRunner { (val, done) in
							Idle {
								if done && val < 100.0 {
									return $progress.wrappedValue = 0.0
								} else if done && val == 100.0 {
									window.close()
									onCompleteCallback()
									return
								}
								$progress.wrappedValue = val
							}
						}
					}
				}
				.style(progress == 0 ? "suggested-action" : "flat")
				.hexpand(true)
				.padding(15)
			}

			if progress > 0 {
				ProgressBar(value: progress, total: 100.0)
			}
    		}
    		.padding(10)
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
}