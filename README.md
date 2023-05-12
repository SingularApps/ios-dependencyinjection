# DependencyInjection

This is a simple lightweight build safe dependency injection framework for Swift.

## Install

Using Swift Package Manager, add the dependency to your target:

```swift
dependencies: [
    .package(url: "https://github.com/SingularApps/ios-dependencyinjection.git", from: "1.0.0")
],
```

And then on your code, don't forget to import it:

```swift
import DependencyInjection
```

## DependencyContainer

The `DependencyContainer` is the most important piece of this package, it's where we will register all dependencies. It has a key-value memory storage that can be used to keep some really important data.

### Key-Value Storage

It is very simple to set and get data from the `DependencyContainer`'s internal storage:

```swift
let container = DependencyContainer()

container.setValue("Test!", forKey: "string")
container.setValue(10, forKey: "int")

let string: String? = container.getValue(forKey: "string") // Optional("Test!")
let int: Int? = container.getValue(forKey: "int") // Optional(10)
let float: Float? container.getValue(forKey: "int") // nil
```

### Static Containers

There are a couple of static containers that can be used anywhere in your code, the `default` and the `mocks`. Both can be accesed directly, but there is a third one that will be key in the next session, the `main` container. You can change the `main` container at any time and as it is a `static var`, it will be automatically changed everywhere you use it. This is handy when you need to switch to the `mocks` container when running unit tests, for instance.

```swift
DependencyContainer.main = .mocks
```

Finally, you are free to add new containers anytime:

```swift
extension DependencyContainer {
	static let custom: DependencyContainer = {
		let container = DependencyContainer()
		// do something
		return container
	}()
}

DependencyContainer.main = .custom
```

### Register/Resolve Dependencies

In order to register your dependencies, you just need to add some `static computed properties` to the `DependencyContainer` class:

```swift
extension DependencyContainer {

	var baseUrl: String {
		"https://api.server.com"
	}
	
	var dataFromStorage: Data? {
		getValue(forKey: "data")
	}
}
```

In that way, you will be able to resolve it at any time when needed:

```swift
var baseUrl = container.baseUrl
var data = container.dataFromStorage // Exists only when that value was set in the container's storage
```

### Mocks

Let's just talk a little bit about the static `mocks` container. This is a very powerful way of unit test your code. When you are registering your dependencies, you can use the `isMocked` property that already exists on the `DependencyContainer` in your logic. In that way, for instance, you can get the mocked data while running the unit tests:

```swift
extesion DependencyContainer {

	var loginService: LoginServiceProtocol {
		if isMocked {
			return MockLoginService()
		}
		return LoginService()
	}
}
```

## @Dependency

This property wrapper acts as the automatic dependency resolver for your objects. You can use it on its properties and they will be resolved at the time of the first access, like a `lazy` property. We can simply use the `@Dependency` property wrapper with the `KeyPath` of the dependency:

```swift
class ViewModel {

	@Dependency(\.baseUrl) var baseUrl // "https://api.server.com"
	@Dependency(\.loginService) var loginService
}
```

That's it! Simple, right? If you don't have the `computed property`, the compiler will not build, so it is compilation safe.

The `@Dependency` property wrapper uses the `main` static `DependencyContainer`, but it can use a custom one that can be set individually:

```swift
viewModel.$loginService.container = .mocks
```

## Release Notes

See [CHANGELOG.md](https://github.com/SingularApps/ios-dependencyinjection/blob/main/CHANGELOG.md) for a list of changes.

## License

This package is available under the MIT license. See the LICENSE file for more info.