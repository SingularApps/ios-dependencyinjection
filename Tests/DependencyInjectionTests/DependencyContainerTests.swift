import XCTest
@testable import DependencyInjection

final class DependencyContainerTests: XCTestCase {
    
    // MARK: - Storage
    
    private let key = "test"

    func testValue() throws {
        let container = DependencyContainer()
        
        container.setValue("Test!", forKey: key)
        
        let string: String? = container.getValue(forKey: key)
        XCTAssertNotNil(string)
        XCTAssertEqual(string, "Test!")
        
        let int: Int? = container.getValue(forKey: key)
        XCTAssertNil(int)
    }
    
    func testReference() throws {
        let container = DependencyContainer()
        
        let john = Person(name: "John")
        container.setValue(john, forKey: key)
        
        let person: Person? = container.getValue(forKey: key)
        XCTAssertNotNil(person)
        XCTAssertEqual(person?.name, "John")
        
        let int: Int? = container.getValue(forKey: key)
        XCTAssertNil(int)
        
        john.name = "Mark"
        XCTAssertEqual(person?.name, john.name)
    }
    
    func testProtocol() throws {
        let container = DependencyContainer()
        
        container.setValue("Test!" as Dummy, forKey: key)
        
        var dummy: Dummy? = container.getValue(forKey: key)
        XCTAssertNotNil(dummy)
        XCTAssertEqual(dummy?.dummy, 5)
        
        var int: Int? = container.getValue(forKey: key)
        XCTAssertNil(int)
        
        container.setValue(20 as Dummy, forKey: key)
        
        dummy = container.getValue(forKey: key)
        XCTAssertNotNil(dummy)
        XCTAssertEqual(dummy?.dummy, 20)
        
        int = container.getValue(forKey: key)
        XCTAssertNotNil(int)
        XCTAssertEqual(int?.dummy, 20)
    }
    
    func testRemoveValue() throws {
        let container = DependencyContainer()
        
        container.setValue("Test!", forKey: key)
        
        var string: String? = container.getValue(forKey: key)
        XCTAssertNotNil(string)
        XCTAssertEqual(string, "Test!")
        
        container.removeValue(forKey: key)
        
        string = container.getValue(forKey: key)
        XCTAssertNil(string)
    }
    
    func testRemoveAll() throws {
        let container = DependencyContainer()
        
        container.setValue("Test!", forKey: "string")
        container.setValue(10, forKey: "int")
        
        var string: String? = container.getValue(forKey: "string")
        XCTAssertNotNil(string)
        XCTAssertEqual(string, "Test!")
        
        var int: Int? = container.getValue(forKey: "int")
        XCTAssertNotNil(int)
        XCTAssertEqual(int, 10)
        
        container.removeAll()
        
        string = container.getValue(forKey: "string")
        XCTAssertNil(string)
        
        int = container.getValue(forKey: "int")
        XCTAssertNil(int)
    }
    
    // MARK: - Static Containers
    
    func testDefaultContainer() throws {
        let container = DependencyContainer.default
        let name = container.containerName
        XCTAssertEqual(name, "Default")
    }
    
    func testMockContainer() throws {
        let container = DependencyContainer.mocks
        let name = container.containerName
        XCTAssertEqual(name, "Mocks")
    }
    
    func testSwitchMainContainer() throws {
        DependencyContainer.main = .default
        XCTAssertEqual(DependencyContainer.main.containerName, "Default")
        DependencyContainer.main = .mocks
        XCTAssertEqual(DependencyContainer.main.containerName, "Mocks")
    }
}
