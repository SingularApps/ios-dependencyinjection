/// The dependency injector
@propertyWrapper
public struct Dependency<Service> {
    
    /// Main dependency container that is used in the @Dependency property wrapper
    public var container: DependencyContainer
    
    /// KeyPath for the dependency
    public var keyPath: KeyPath<DependencyContainer, Service>
    
    /// Resolved dependency
    private var service: Service!
    
    /// Initialization check
    private var isInitialized = false
    
    /// Initiates the property wrapper with a KeyPath and using the static .main container
    /// - Parameters:
    ///   - keyPath: Optional name for the dependency
    ///   - container: Conteiner for the dependency
    public init(_ keyPath: KeyPath<DependencyContainer, Service>, container: DependencyContainer = .main) {
        self.keyPath = keyPath
        self.container = container
    }
    
    /// Property wrapper wrapped value
    public var wrappedValue: Service {
        mutating get {
            if !isInitialized {
                service = container[keyPath: keyPath]
                isInitialized = true
            }
            return service
        }
        mutating set {
            service = newValue
            isInitialized = true
        }
    }
    
    /// Property wrapper projected value
    public var projectedValue: Dependency<Service> {
        get { return self }
        mutating set { self = newValue }
    }
    
    /// Resets the property wrapper to the default settings
    public mutating func reset() {
        service = nil
        isInitialized = false
    }
}
