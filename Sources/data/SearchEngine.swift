import Foundation

struct SearchEngine: Codable, Identifiable, CustomStringConvertible {
    var id: String
    var url: String
    var label: String

    var description: String {
    		label
    }

    func query(_ text: String) -> URL {
    		return URL(string: "\(url)\(text)")!
    }
}