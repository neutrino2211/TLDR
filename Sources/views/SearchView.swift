import Adwaita

struct SearchView: View {
    var app: GTUIApp
    var window: GTUIApplicationWindow
    var queryProgress: Double

	var view: Body {
		VStack {
			Text("Making query")
			.style("title-1")
			.padding()

			ProgressBar(value: queryProgress, total: 100)
		}
		.padding()
	}
}