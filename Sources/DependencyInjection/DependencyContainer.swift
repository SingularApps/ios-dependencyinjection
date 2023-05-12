/// This is the container to store/resolve all dependencies.
public class DependencyContainer {
    
    /// The default container.
    public static let `default` = DependencyContainer()
    
    /// The container for mocking.
    public static let mocks: DependencyContainer = {
        let container = DependencyContainer()
        container.setValue(true, forKey: "isMocked")
        return container
    }()
    
    /// The main container used in the @Dependency property wrapper. It can be replaced for a global change.
    public static var main: DependencyContainer = .default
    
    /// This dictionary stores any data needed.
    private var storage: [String: Any] = [:]
    
    /// Set any value for a key in the storage.
    /// - Parameters:
    ///   - value: Any value
    ///   - key: String key
    public func setValue(_ value: Any, forKey key: String) {
        storage[key] = value
    }
    
    ///  Get the value for a key casting to a generic type.
    /// - Parameter key: String key
    /// - Returns: Value if it's the same type or nil
    public func getValue<T>(forKey key: String) -> T? {
        storage[key] as? T
    }
    
    /// Remove a value for a given key.
    /// - Parameter key: String key
    public func removeValue(forKey key: String) {
        storage.removeValue(forKey: key)
        storage[key] = nil
    }
    
    /// Remove all keys from the storage.
    public func removeAll() {
        storage = [:]
    }
    
    /// Check if the container is for mocking.
    var isMocked: Bool {
        getValue(forKey: "isMocked") ?? false
    }
}

