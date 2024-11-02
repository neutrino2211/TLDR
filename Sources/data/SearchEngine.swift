import Foundation

struct SearchEngine: Codable, Identifiable, CustomStringConvertible {
    var id: String
    var url: String
    var label: String

    var description: String {
    		label
    }

    func query(_ text: String) -> URL {
    		let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
    		let link = URL(string: "\(url)\(encodedText)")
    		return link!
    }
}

let searchEnginesMap: [String: SearchEngine] = [
	"google": .init(id: "google", url: "https://google.com/search?q=", label: "Google"),
	"duck": .init(id: "duck", url: "https://duckduckgo.com/?q=", label: "DuckDuckGo"),
    	"custom": .init(id: "custom", url: "", label: "Custom")
]

struct SearchEngineSettings: Codable {
	var dictionary: [String: String] = .init()

	var engine: String {
		get {
			return self.dictionary["engine"] ?? "google"
		}

		set {
			self.dictionary["engine"] = newValue
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