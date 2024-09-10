import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: authStatus == AuthStatus.unauthenticated
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
                },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
                },
              child: Text('Sign Up'),
            ),
          ],
        )
        : ElevatedButton(
          onPressed: () {
            ref.read(authProvider.notifier).unauthenticate();
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
