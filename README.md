# Flutter Google Docs Clone

A feature-rich Google Docs Clone built using Flutter, Node.js, Socket.io, and MongoDB. This project offers a collaborative document editing experience with real-time synchronization across web and mobile platforms.

## Features

- Real-time collaborative document editing similar to Google Docs.
- Support for both web and mobile platforms.
- User authentication and authorization using Google Sign-In.
- Seamless integration with Socket.io for real-time communication.
- Persists documents in a MongoDB database.
- Rich text editing capabilities with Flutter Quill.
- Efficient state management using Flutter Riverpod.

## Tech Stack

- **Flutter:** Flutter SDK is used for developing the mobile and web application.
- **Node.js:** Backend server built with Node.js to handle authentication and document operations.
- **Socket.io:** Enables real-time communication between clients and the server.
- **MongoDB:** A NoSQL database used to store and retrieve documents.
- **Flutter Quill:** A rich text editor for Flutter, providing text formatting and styling capabilities.
- **Flutter Riverpod:** A state management library for Flutter, offering a simple and scalable way to manage app state.
- **Google Sign-In:** Allows users to sign in using their Google accounts.
- **HTTP:** A package for making HTTP requests from Flutter.

## Getting Started

Follow the instructions below to set up and run the Google Docs Clone:

### Prerequisites

- Install Flutter: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Install Node.js: [Node.js Official Website](https://nodejs.org/)

### Frontend (Flutter)

1. Clone the repository:

```shell
git clone https://github.com/SanskarModi22/Google-Docs-Clone.git
```

2. Change to the project directory:

```shell
cd google_docs_clone
```

3. Install the Flutter dependencies:

```shell
flutter pub get
```

4. Run the app:

```shell
flutter run
```

### Backend (Node.js)

1. Navigate to the backend directory:

```shell
cd backend
```

2. Install the Node.js dependencies:

```shell
npm install
```

3. Start the server:

```shell
npm start
```

### Configuration

- Make sure to update the MongoDB connection details in the backend's `.env` file.
- Configure the appropriate OAuth settings in the Flutter app for Google Sign-In.

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please create an issue on the GitHub repository.

## License

This project is licensed under the [MIT License](LICENSE).
```

Feel free to customize the README file according to your project's specific details and instructions.
