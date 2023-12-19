# Pokemon App

Welcome to the Pokemon App. This is a simple iOS application built using SwiftUI, Combine, and the latest version of Xcode. The app fetches and displays a list of Pokemon from the PokeAPI, allowing users to explore and filter Pokemon by type.

![Pokemon App](https://victorsanchez.dev/images/pokemonApp.gif)

## Technical Requirements and Description

### 1. SwiftUI, Cocoapods, Combine, and Xcode 15

The app is developed using SwiftUI, making the most of the latest features and improvements provided by Apple's frameworks. The project is built using the latest version of Xcode (15.1) to ensure compatibility and take advantage of the latest tools.

### 2. Design Patterns

To maintain a clean and scalable codebase, the app incorporates design patterns such as MVVM (Model-View-ViewModel) for architecture. This helps to separate concerns and enhance code maintainability.

### 3. PokeAPI Integration

The app utilizes the PokeAPI to retrieve Pokemon data. This includes details such as name, type, moves and abilities, ensuring that users have access to comprehensive information about each Pokemon.

### 4. SOLID Principles and Good Practices

The principles of SOLID (Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, and Dependency Inversion) are followed to create a robust and maintainable codebase. Good coding practices are adhered to, promoting readability and scalability.

### 5. Image Loading Library

For efficient image loading, the app incorporates a third-party library—specifically, [KingFisher](https://github.com/onevcat/Kingfisher). This library streamlines the process of downloading and caching Pokemon images, contributing to a smoother user experience.

### 6. Responsive UI

The app's user interface is designed to be responsive across different iOS devices and orientations. Whether on an iPhone or iPad, in portrait or landscape mode, users can enjoy a seamless and visually appealing experience.

### 7. Unit Tests for Networking Layer

The networking layer of the app is thoroughly tested using unit tests. This ensures the reliability and correctness of the data fetching mechanism, providing a solid foundation for the app's functionality.

### 8. Pokemon Filtering

Users can filter Pokemon based on type, allowing for a customized exploration experience. This feature enhances usability and caters to users with specific preferences or interests.

### 9. Pagination

To improve the performance and loading time of the Pokemon list, the app implements pagination. Users can smoothly scroll through an extensive list of Pokemon without experiencing lag or delays.

### 10. Initial Screen Example

The first screen of the app showcases a list of Pokemon, demonstrating the app's core functionality. The user interface is thoughtfully designed.

## Getting Started

To run the Pokemon Fetcher App on your local machine, follow these steps:

1. Clone the repository.
2. Install Cocoapods
3. Run pod install
4. Open the project in Xcode usin the .xcworkspace file.
5. Build and run the app on a simulator or physical device.
