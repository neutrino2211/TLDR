import CAdw
import Adwaita

enum ImageSize: Int {
	case inherit = 0
	case normal = 1
	case large = 2
}

struct Image: Widget {
	var iconName: String
	var pixelSize: Int32?

	var marginBottom: Int32?

    func container(modifiers: [(View) -> View]) -> ViewStorage {
    		let img = gtk_image_new()!

    		gtk_image_set_from_icon_name(img.toOpaque(), iconName)
    		
    		if let ic = pixelSize {
    			gtk_image_set_pixel_size(img.toOpaque(), ic)
    		}

    		let storage = ViewStorage(img.toOpaque())

    		update(storage, modifiers: modifiers, updateProperties: true)

    		return storage
    }

    func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) -> () {
    		storage.modify { _ in
    			if let mb = marginBottom {
				gtk_widget_set_margin_bottom(storage.pointer?.cast(), mb)
			}
    		}
    }

    public func marginBottom(margin: Int32) -> Self {
    		var newSelf = self
    		newSelf.marginBottom = margin

    		return newSelf
    }
}