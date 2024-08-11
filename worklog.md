# Worklog

## 2024-08-11
`Scene` is a lifecycle-aware entity. This means a `Scene` can respond to and manage different stages in the lifecycle of a part of the user interface. Let's break this down:

**Lifecycle Stages**: Just like any application, a SwiftUI app goes through various stages during its run, such as *initialization, becoming active, entering the background, and termination.* Each of these stages represents a different state in the app's lifecycle.

**Responsiveness to Lifecycle Events**: Being "lifecycle aware" means that the `Scene` (or any other lifecycle-aware component) can respond to these lifecycle events. For example, a Scene can execute specific code when the app becomes active or when it's about to enter the background.

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