# TCA-Based SwiftUI Application

This project demonstrates the use of **The Composable Architecture (TCA)** in SwiftUI. It includes two examples that showcase how to build scalable and modular state management in iOS applications using TCA.

## Motivation

The purpose of this project is to explore and understand **Point-Free's TCA**, a robust state management architecture designed for SwiftUI. The architecture allows you to manage state, side effects, and navigation in a clean and scalable way. The project features two examples that cover different use cases in SwiftUI development: state management and navigation.

In terms of TCA, this project demonstrates example for Reducers, Actions, States, Navigation and Effects

## Examples

### 1. `CounterView`
A simple example that demonstrates:

- **State Management**: Using a TCA reducer to manage a counter's state.
- **Actions**: Increment and decrement the counter.
- **ViewStore**: Interaction with the state and actions via a `ViewStore`.

The `CounterView` helps you understand how TCA can handle state updates and actions in a straightforward way.

### 2. `ContactsView`
This example is focused on **navigation** and **form management**, allowing users to:

- **Add a contact**: A simple form to add a contact's name.
- **Dismiss and Cancel Navigation**: Handling navigation using TCA’s effects, demonstrating how to dismiss or cancel a modal/presented view.

The `ContactsView` shows how to handle navigation in SwiftUI apps, with an emphasis on canceling or dismissing presentations, making it a great learning example for managing side effects in navigation.

## Getting Started

### Prerequisites
Ensure you have the following installed:
- Xcode (latest version)
- Swift 5.0 or higher
- iOS 16+ (for SwiftUI compatibility)

### Installation

Clone this repository to your local machine:
- git clone https://github.com/khanboy1989/GettingStartedWithTCA.git


### Open The Project 
  - cd your-project
  - open GettingStartedWithTCA.xcodeproj



