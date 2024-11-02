import Foundation
import Adwaita
import CAdw

extension Pipe {
	public func toString() -> String {
		let data = self.fileHandleForReading.readDataToEndOfFile()
		let output = String(data: data, encoding: .utf8)!

		return output
	}
}

extension Data {
	public func toString() -> String {
		return String(data: self, encoding: .utf8)!
	}
}

func ShellCommand(command: String) throws -> (Pipe, Process) {
	let task = Process()
	let pipe = Pipe()
	let errPipe = Pipe()


	task.standardOutput = pipe
    task.standardError = errPipe
    task.arguments = ["-c", command]
    task.executableURL = URL(fileURLWithPath: "/bin/sh")
    task.standardInput = nil
    try task.run()

    errPipe.fileHandleForReading.readabilityHandler = { h in
    		 print(h.availableData.toString())
    }

    return (errPipe, task)
}

func OllamaCommandRunner(progressCallback: @escaping (Double, Bool) -> ()) {
	var progressDouble = 0.1

	do {
		let copyScript = try ShellCommand(command: "cp /app/bin/install_ollama.sh ~/Downloads/install_ollama.sh").0.toString()
		print(copyScript)

		let cmd = try ShellCommand(command: "flatpak-spawn --host pkexec ~/Downloads/install_ollama.sh")

		let installOllamaPipe = cmd.0, installOllamaProcess = cmd.1

		let reader = installOllamaPipe.fileHandleForReading

		reader.readabilityHandler = { fh in
			let out = fh.availableData.toString()

			print(out)

			if let idx = out.index(of: "%") {
				var sub = out[..<idx]
				if let space_idx = out.endIndex(of: " ") {
					sub = sub[space_idx...]
					var subString = String(sub)
					subString = subString.trimmingCharacters(in: .whitespacesAndNewlines)

					let ollamaProgress = (subString as NSString).doubleValue

					progressDouble = ollamaProgress
					progressCallback(ollamaProgress, false)
				}
			}
		}

		installOllamaProcess.terminationHandler = { _ in
			progressCallback(progressDouble, true)
		}

	} catch {
		print("Install ollama \(error)")
	}
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
