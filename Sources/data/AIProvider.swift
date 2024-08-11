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