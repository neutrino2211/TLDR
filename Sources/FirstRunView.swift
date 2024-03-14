import Adwaita

struct FirstRunView: View {

	@State private var installingOllama = false
	@State private var installationText = ""

	var view: Body {
		VStack {
			Image(iconName: "io.github.neutrino2211.TLDR", pixelSize: 128)
				.marginBottom(margin: 30)

			Text("Welcome to TLDR")
				.style("title-1")
				.padding(30, .bottom)

			Text("TLDR helps you make sense of random searches")
				.padding()

			HStack {
				Button()
					.clicked {
						print("Skip :(")
					}
					.label("Skip Install")
					.padding()

				Button()
					.clicked {
						if installingOllama {return}
						print("Install Ollama")
						installingOllama = true
						InstallOllama(progress: $installationText)
						installingOllama = false
					}
					.label(installingOllama ? "Installing Ollama" : "Install Ollama")
					.style("suggested-action")
					.padding()
			}
			.halign(.center)
			.hexpand(true)

			Text(installationText)

			Spinner()
				.spinning(installingOllama)
		}
		.padding()
		.valign(.center)
		.halign(.center)
		.vexpand(true)
	}
}