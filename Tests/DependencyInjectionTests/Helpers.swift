import Foundation
@testable import DependencyInjection

protocol Dummy {
    var dummy: Int { get }
}

extension String: Dummy {
    var dummy: Int { count }
}

extension Int: Dummy {
    var dummy: Int { self }
}

class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}

extension DependencyContainer {
    var value: Int {
        30
    }
    
    var reference: Person {
        Person(name: "John")
    }
    
    var interface: Dummy {
        "Mark"
    }
    
    var stored: Int? {
        getValue(forKey: "age")
    }
    
    var containerName: String {
        if isMocked {
            return "Mocks"
        }
        return "Default"
    }
}

class ViewModel {
    @Dependency(\.value) var value
    @Dependency(\.reference) var reference
    @Dependency(\.interface) var interface
    @Dependency(\.stored) var stored
    @Dependency(\.containerName) var containerName
}
