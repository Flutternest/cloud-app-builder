# Cloud Wrapper Builder

<p align="center">
  <img src="https://github.com/Flutternest/cloud-app-builder/blob/main/assets/images/logo_dark.png?raw=true" alt="Logo">
</p>
This repository contains the source code for builder, a comprehensive solution designed to streamline your daily tasks and enhance productivity. The app offers a user-friendly interface, robust features, and seamless integration with various services.


## Video Demo
Check out our video demo to see builder in action:

https://github.com/Flutternest/cloud-app-builder/raw/refs/heads/main/demo/viddemo.mov

## Table of Contents
- [Features](#features)
- [Architecture](#architecture)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Features
- **User Authentication**: Secure login and registration using Firebase.
- **App Management**: Create, update, and delete apps with ease.
- **Notifications**: Receive timely reminders for your tasks.
- **Dark Mode**: Switch between light and dark themes.

## Architecture
The application follows the Model-View-Controller (MVC) architecture. Here are the main components:

### Model
- **Data Models**: Represent the data structure of the application (e.g., `Task`, `User`).
- **Repositories**: Handle data fetching and caching (e.g., [`builderRepositoryProvider`](lib/repositories/builder_repository.dart)).

### View
- **UI Components**: Built with Flutter's `Material` widgets.
- **Screens and Widgets**: Display data and handle user interactions (e.g., `HomeView`, `LoginPage`).

### Controller
- **State Management**: Using `hooks_riverpod` for state management.
- **Controllers**: Manage the logic and state of the application (e.g., `AuthController`, `TaskProvider`).

### Additional Components
- **Networking**: Handled by `dio` for HTTP requests.
- **JSON Serialization**: Using `json_serializable` for JSON parsing.
- **Firebase Services**: Authentication, Firestore, and Cloud Messaging.

## Installation
To get started with the project, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/flutternest/cloud-app-builder.git && cd cloud-app-builder
    ```

2. Install the dependencies:
    ```bash
    flutter pub get
    ```

3. Set up the Firebase configuration:
    - Add your `google-services.json` file to the `android/app` directory.

4. Run the project:
    ```bash
    flutter run
    ```

## Usage
To use builder, simply run the project on an Android or iOS device. The app will allow you to manage your tasks efficiently, set reminders, and stay productive.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate (if any).

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.