// ignore_for_file: public_member_api_docs, sort_constructors_first
// This is a Dart file that defines an authentication controller class and some associated providers.

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

import '../constants/host_service.dart';
import '../models/error_model.dart';
import '../models/user_account.dart';

// Define a provider that creates an instance of the AuthController class.
final authRepositoryProvider = Provider((ref) => AuthController(
      googleSignIn: GoogleSignIn(),
      client: Client(),
    ));

// Define a provider that provides a user model.
final userProvider = StateProvider<UserModel?>((ref) => null);

// Define the AuthController class.
class AuthController {
  final GoogleSignIn _googleSignIn;
  final Client _client;

  // Define the constructor for the AuthController class.
  AuthController({
    required GoogleSignIn googleSignIn,
    required Client client,
  })  : _googleSignIn = googleSignIn,
        _client = client;

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
        var res = await _client.post(Uri.parse("$host/api/signup"),
            body: accUser.toJson(),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            });

        // Check the response status code.
        switch (res.statusCode) {
          // If the status code is 200, create a new UserModel object with the user ID
          // returned by the server and update the error model with the new user data.
          case 200:
            final newUSer = accUser.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
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
