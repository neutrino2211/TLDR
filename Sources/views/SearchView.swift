import Adwaita

struct SearchView: View {
    var app: GTUIApp
    var window: GTUIApplicationWindow

	var view: Body {
		VStack {
			Text("Making query")
			.style("title-1")
			.padding()

			ProgressBar()
			.pulseStep(0.1)
		}
		.padding()
	}
}