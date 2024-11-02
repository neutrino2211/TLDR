import Adwaita

struct PreferencesView: View {

    var app: GTUIApp
    var window: GTUIApplicationWindow

    @State private var addDialogText = ""
    @State private var focusEntry: Signal = .init()

    @State("searchEngines") var searchEngine: [SearchEngine] = [
    		.init(id: "google", url: "https://google.com/search?q=", label: "Google"),
    		.init(id: "duck", url: "https://duckduckgo.com/search?q=", label: "DuckDuckGo")
    	]
   	@State("selectedSearchEngine") private var selectedSearchEngine = "google"

   	@State("aiProviders") var aiProviders: [AIProvider] = [
   		.init(id: "ollama", label: "Ollama"),
   		.init(id: "fireworks-ai", label: "Fireworks AI"),
   		.init(id: "open-ai", label: "OpenAI"),
   		.init(id: "groq", label: "Groq")
   	]
   	@State("selectedAiProvider") private var selectedAiProvider = "ollama"
   	@State("selectedAiProviderKey") private var selectedAiProviderKey = ""

    var view: Body {
        VStack {
			FormSection("Search") {
				Form {
					ComboRow("Search Engine", selection: $selectedSearchEngine, values: searchEngine)
				}
			}
			.padding()

			FormSection("AI Provider") {
				Form {
					ComboRow("AI Provider", selection: $selectedAiProvider, values: aiProviders)
					PasswordEntryRow("Provider API Key", text: $selectedAiProviderKey)
				}
			}.padding()
        }
        .frame(minWidth: 350)
        .padding()
        .topToolbar {
        		HeaderBar
		    .empty()
		    .headerBarTitle {
				Text(Loc.preferences)
				.style("heading")
			}
        }
        .bottomToolbar {
        		Button("Save") {
        			print("Save")
        			aiOptions.wrappedValue = aiProviderOptions
        			searchOptions.wrappedValue = searchEngineOptions
        		}
        		.padding()
        		.style("suggested-action")
        }
    }

    var actionRows: View {
        Form {
            ActionRow("Rows have a title")
                .subtitle(searchEngineOptions.engine)
            ActionRow("Rows can have suffix widgets")
                .suffix {
                    Button("A1051ction") { }
                        .verticalCenter()
                }
        }
        .padding()
    }

}
