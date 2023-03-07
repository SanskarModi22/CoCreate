import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/host_service.dart';
import '../models/error_model.dart';
import '../models/user_account.dart';

// Define a provider that creates an instance of the AuthController class.
final authRepositoryProvider = Provider((ref) => AuthController(
      googleSignIn: GoogleSignIn(),
      dio: Dio(),
    ));

// Define a provider that provides a user model.
final userProvider = StateProvider<UserModel?>((ref) => null);

// Define the AuthController class.
class AuthController {
  final GoogleSignIn _googleSignIn;
  final Dio _dio;

  // Define the constructor for the AuthController class.
  AuthController({
    required GoogleSignIn googleSignIn,
    required Dio dio,
  })  : _googleSignIn = googleSignIn,
        _dio = dio;
  // The authRepositoryProvider is created to provide an instance of the AuthController class.

// In the context of the Riverpod state management library, providers are objects that provide values to other objects that depend on them. In this case, the authRepositoryProvider is a Provider that creates and provides an instance of the AuthController class to other parts of the app that depend on it.

// Creating a Provider for the AuthController class allows us to easily inject it into other parts of the app and use its methods without having to create a new instance every time we need to use it. This is a common pattern in software development known as dependency injection.

// By using the authRepositoryProvider to provide an instance of the AuthController class, we can ensure that there is only one instance of the AuthController class throughout the app, and that any updates to its state are automatically propagated to all parts of the app that depend on it. This helps to keep the app's state consistent and avoids unnecessary code duplication.

// The Client() object is used in the authRepositoryProvider to create an instance of the AuthController class. The AuthController class uses the Client object to make HTTP requests to the server.

// In Dart, the http package provides a Client class that can be used to make HTTP requests. The Client class is used to send GET, POST, PUT, DELETE, and other types of HTTP requests.

// By creating an instance of the Client class in the authRepositoryProvider and passing it to the AuthController class, we are essentially injecting a Client object into the AuthController class. This allows the AuthController class to make HTTP requests to the server using the Client object, without having to create a new Client object every time it needs to make a request.

// Using a single instance of the Client object throughout the app can also help to improve performance, as it allows connections to be reused and kept alive for multiple requests. This can help to reduce the overhead of creating and closing connections for each request.

  // Define a method that signs in with Google and returns an ErrorModel.
  Future<ErrorModel> signInWithGoogle() async {
    // Initialize the error model with a default error message and null data.
    ErrorModel error =
        ErrorModel(error: 'Something unexpected happened', data: null);
    try {
      // Sign in with Google and get the user object.
      final user = await _googleSignIn.signIn();
      if (user != null) {
        // Create a new UserModel object from the Google user object.
        final accUser = UserModel(
          email: user.email,
          name: user.displayName!,
          photoUrl: user.photoUrl!,
          uid: "",
          token: "",
        );

        // Send a POST request to the server to sign up the user.
        final res = await _dio.post('$host/api/signup',
            data: accUser.toJson(),
            options: Options(headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            }));
        print(res);
        // Check the response status code.
        switch (res.statusCode) {
          // If the status code is 200, create a new UserModel object with the user ID
          // returned by the server and update the error model with the new user data.
          case 200:
            final newUSer = accUser.copyWith(
              uid: res.data['user']['_id'],
            );
            error = ErrorModel(error: null, data: newUSer);
            break;
          // If the status code is not 200, print an error message to the console.
          default:
            print('error');
        }
      }
    } catch (e) {
      // If an exception occurs, update the error model with the exception message.
      error = ErrorModel(error: e.toString(), data: null);
    }
    // Return the error model.
    return error;
  }
}
