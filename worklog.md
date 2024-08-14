# Worklog

## 2024-08-14
Gestures all follow the similar rule:
```swift
MagnifyGesture()
    .updating($magnifyAmount) { value, state, _ in
        state = value.magnification
    }
```
Example:
```swift
struct MyView: View {
        @GestureState private var dragAmount = CGSize.zero
        @State private var offset = CGSize.zero

        var body: some View {
            VStack {
                Image(systemImage: "globe")
                    .offset(
                        x: offset.width + dragAmount.width,
                        y: offset.height + dragAmount.height
                    )
                    .gesture(dragGesture)
            }
        }
        
        var dragGesture: some Gesture {
            DragGesture()
                .updating($dragAmount) { value, state, _ in
                    state = value.translation
                }
                .onEnded { value in
                    offset = CGSize(
                        width: offset.width + value.translation.width,
                        height: offset.height + value.translation.height
                    )
                }
       }
}

```

## 2024-08-11
`Scene` is a lifecycle-aware entity. This means a `Scene` can respond to and manage different stages in the lifecycle of a part of the user interface. Let's break this down:

**Lifecycle Stages**: Just like any application, a SwiftUI app goes through various stages during its run, such as *initialization, becoming active, entering the background, and termination.* Each of these stages represents a different state in the app's lifecycle.

**Responsiveness to Lifecycle Events**: Being "lifecycle aware" means that the `Scene` (or any other lifecycle-aware component) can respond to these lifecycle events. For example, a Scene can execute specific code when the app becomes active or when it's about to enter the background.

---
When you apply a property wrapper to a property, the compiler synthesizes additional code that gets executed when the property is accessed or modified. This process allows you to add additional logic (like validation, storage, or transformation) to the property.

Data flow in SwiftUI is controlled through a variety of property wrappers that allow views to read or write data. These include `@State`, `@Binding`, `@ObservedObject`, and more.

`@State`: For internal state within a single view.

`@Binding`: For passing state between parent and child views. A small d etour: A binding ensures a two-way data flow, so that the UI can both display data and change it, enabling interactive and dynamic interfaces. Binding can be achieved by using the `$` prefix. And this Binding is different from the State property wrapper.

`@ObservedObject`: For sharing more complex state between multiple views.

## 2024-08-07
Conform to the `Codable` protocol to encode and decode the data. Conform to the `CustomStringConvertible` protocol to print the data in a human-readable format.

Conform essentially means to add additional functionality to the struct or class.

## 2024-08-05
Current work flow:
1. Create a new swift playground for every project
2. Using the autocomplete feature to write code
3. Copy code to the vanilla script
4. Compilte the script: `swiftc main.swift`
5. Run the script: `./main`