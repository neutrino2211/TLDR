import Foundation
import Adwaita

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

func ShellCommand(command: String) throws -> Pipe {
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

    return pipe
}

func InstallOllama(progress: Binding<String>) {
	do {
		let copyScript = try ShellCommand(command: "cp /app/bin/install_ollama.sh ~/Downloads/install_ollama.sh").toString()
		print(copyScript)

		let installOllama = try ShellCommand(command: "flatpak-spawn --host pkexec ~/Downloads/install_ollama.sh")

		let reader = installOllama.fileHandleForReading

		reader.readabilityHandler = { fh in
			let out = fh.availableData.toString()
			print(out)

			if out.hasSuffix("%\n") {
				progress.wrappedValue = out
			}
		}
	} catch {
		print("Install ollama \(error)")
	}

}
