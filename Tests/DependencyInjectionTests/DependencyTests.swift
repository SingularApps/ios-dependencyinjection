import XCTest
@testable import DependencyInjection

final class DependencyTests: XCTestCase {
    
    override class func tearDown() {
        DependencyContainer.main.removeAll()
    }

    func testResolveValueDependency() throws {
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.value, 30)
    }
    
    func testResolveReferenceDependency() throws {
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.reference.name, "John")
    }
    
    func testResolveInterfaceDependency() throws {
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.interface.dummy, 4)
    }
    
    func testResolveStoredDependency() throws {
        DependencyContainer.main.setValue(35, forKey: "age")
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.stored, 35)
    }
    
    func testResetDependency() throws {
        DependencyContainer.main.setValue(35, forKey: "age")
        
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.stored, 35)
        
        viewModel.stored = 20
        XCTAssertEqual(viewModel.stored, 20)
        
        viewModel.$stored.reset()
        XCTAssertEqual(viewModel.stored, 35)
    }
    
    func testChangeContainer() throws {
        let container = DependencyContainer()
        container.setValue(40, forKey: "age")
        
        let viewModel = ViewModel()
        viewModel.$stored.container = container
        XCTAssertEqual(viewModel.stored, 40)
    }
    
    func testChangeMainContainer() throws {
        DependencyContainer.main = .mocks
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.containerName, "Mocks")
        DependencyContainer.main = .default
    }
}

