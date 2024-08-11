import Adwaita
import CAdw

struct Entry: Widget {
	var placeholder: String
	var icon: Icon?
	var onSubmit: ((_ text: String) -> Void)?


    public func container(modifiers: [(View) -> View]) -> ViewStorage {
    		let storage: ViewStorage = .init(gtk_entry_new()?.opaque())

    		gtk_entry_set_placeholder_text(storage.pointer?.cast(), placeholder)

    		update(storage, modifiers: modifiers, updateProperties: true)

    		return storage
    }

    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {
		if let onSubmit {
			storage.connectSignal(name: "activate", argCount: 0) {
				if let buffer = gtk_entry_get_buffer(storage.pointer?.cast()) {
					let text = gtk_entry_buffer_get_text(buffer)
					onSubmit(.init(cString: text!))
					gtk_entry_buffer_set_text(buffer, "".cString(using: .utf8), 0)
				}
			}
		}

		storage.modify { widget in
			if let icon, updateProperties {
				gtk_entry_set_icon_from_icon_name(widget?.cast(), GTK_ENTRY_ICON_SECONDARY, icon.string)
			}
		}
    }

    public func onSubmit(_ submitFn: @escaping (_ text: String) -> Void) -> Self {
    		var newSelf = self

    		newSelf.onSubmit = submitFn

    		return newSelf
    }

    public func icon(_ icon: Icon) -> Self {
    		var newSelf = self

    		newSelf.icon = icon

    		return newSelf
    }
}