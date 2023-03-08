import 'package:docs_clone/ui/document_screen_ui.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import '../ui/home_ui.dart';
import '../ui/login_ui.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(child: LoginScreen()),
});
final loggedInRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(child: HomeScreen()),
  '/document/:id': (route) => MaterialPage(
          child: DocumentScreen(
        id: route.pathParameters['id'] ?? '',
      )),
});
