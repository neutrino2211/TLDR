import Foundation

struct AIProvider: Codable, Identifiable, CustomStringConvertible {
    var id: String
    var label: String
    var apiKey: String?
    var selected: Bool = false

    var description: String {
    		label
    }
}

let aiProvidersMap: [String: AIProvider] = [
	"ollama": .init(id: "ollama", label: "Ollama"),
   	"fireworks-ai": .init(id: "fireworks-ai", label: "Fireworks AI"),
   	"open-ai": .init(id: "open-ai", label: "OpenAI"),
   	"groq": .init(id: "groq", label: "Groq"),
   	"custom": .init(id: "custom", label: "Custom")
]

struct AIProviderSettings: Codable {
	var dictionary: [String: String] = .init()

	var provider: String {
		get {
			return self.dictionary["provider"] ?? "ollama"
		}

		set {
			self.dictionary["provider"] = newValue
		}
	}

	var key: String {
		get {
			return self.dictionary["key"] ?? ""
		}

		set {
			self.dictionary["key"] = newValue
		}
	}

	var model: String {
		get {
			return self.dictionary["model"] ?? ""
		}

		set {
			self.dictionary["model"] = newValue
		}
	}

	var customUrl: String {
		get {
			return self.dictionary["customUrl"] ?? ""
		}

		set {
			self.dictionary["customUrl"] = newValue
		}
	}
}