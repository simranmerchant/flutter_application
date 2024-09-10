import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthStateNotifier extends StateNotifier<AuthStatus> {
  AuthStateNotifier() : super(AuthStatus.unauthenticated);


  void authenticate() {
    state = AuthStatus.authenticated;
  }

  void unauthenticate() {
    state = AuthStatus.unauthenticated;
  }
}

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthStatus>(
  (ref) => AuthStateNotifier(),
);