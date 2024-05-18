import Adwaita
import CAdw

struct Image: Widget {
	var icon: Icon
	var size: Int32

    public func container(modifiers: [(View) -> View]) -> ViewStorage {
    		let storage: ViewStorage = .init(gtk_image_new()?.opaque())

    		gtk_image_set_from_icon_name(storage.pointer, icon.string)
    		gtk_image_set_pixel_size(storage.pointer, size)

    		return storage
    }

    public func update(_ storage: ViewStorage, modifiers: [(View) -> View], updateProperties: Bool) {

    }
}