import Adwaita

// Convert pointer to uint64
public extension UnsafeMutablePointer {
  func toUInt64() -> UInt64 {
    return UInt64(bitPattern:Int64(Int(bitPattern: self)))
  }

  func toOpaque() -> OpaquePointer? {
    return OpaquePointer(bitPattern: UInt(self.toUInt64()))
  }
}

// Convert pointer to NativeWidgetPeer
public extension UnsafeMutableRawPointer {
  func toUInt64() -> UInt64 {
    return UInt64(bitPattern:Int64(Int(bitPattern: self)))
  }

  func toOpaque() -> OpaquePointer? {
    return OpaquePointer(bitPattern: UInt(self.toUInt64()))
  }
}

// Convert uint64 to pointers
public extension UInt64 {
  func toPointer<T>() -> UnsafeMutablePointer<T> {
    return UnsafeMutablePointer(bitPattern: UInt(self))!
  }

  func toOpaque() -> OpaquePointer? {
    return OpaquePointer(bitPattern: UInt(self))
  }
}

public extension OpaquePointer {
	func toPointer<T>() -> UnsafeMutablePointer<T> {
		return UnsafeMutablePointer(bitPattern: UInt(self.hashValue))!
	}
}
