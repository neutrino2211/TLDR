import Adwaita

struct PreferencesView: View {

    var app: GTUIApp
    var window: GTUIApplicationWindow
    var aiOptions: Binding<AIProviderSettings>
    var searchOptions: Binding<SearchEngineSettings>

    	@State("searchEngines") private var searchEngines: [SearchEngine] = Array(searchEnginesMap.values)
    @State("aiProviders") private var aiProviders: [AIProvider] = Array(aiProvidersMap.values)

   	@State("searchEngineOptions") private var searchEngineOptions: SearchEngineSettings = .init()
   	@State("aiProviderOptions") private var aiProviderOptions: AIProviderSettings = .init()

   	public func listenProvider(provider: Binding<String>) -> Self {
		provider.wrappedValue = $aiProviderOptions.provider.wrappedValue
   		return self
   	}

    var view: Body {
        VStack {
			FormSection("Search") {
				Form {
					ComboRow("Search Engine", selection: $searchEngineOptions.engine, values: searchEngines)

					if searchEngineOptions.engine == "custom" {
						EntryRow("Custom Search URL", text: $searchEngineOptions.customUrl)
					}
				}
			}
			.padding()

			FormSection("AI") {
				Form {
					ComboRow("Provider", selection: $aiProviderOptions.provider, values: aiProviders)
					EntryRow("Provider Model", text: $aiProviderOptions.model)
					PasswordEntryRow("Provider API Key", text: $aiProviderOptions.key)

					if aiProviderOptions.provider == "custom" {
						EntryRow("Custom AI URL", text: $aiProviderOptions.customUrl)
					}
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
