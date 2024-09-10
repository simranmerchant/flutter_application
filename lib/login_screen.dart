import 'package:flutter/material.dart';
import 'package:flutter_application_3/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import 'package:logger/logger.dart';


class LoginState {
  final String user;
  final String password;
  Logger logger = Logger();

  LoginState({this.user = '', this.password = ''});

  LoginState copyWith({String? user, String? password}) {
    return LoginState(
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }
}

class LoginStateNotifier extends StateNotifier<LoginState> {
  LoginStateNotifier() : super(LoginState());

  final users = ['user1', 'user2', 'user3'];
  final passwords = ['password1', 'password2', 'password3'];

  void storeUser(String user) {
    state = state.copyWith(user: user);
  }

  void storePassword(String password) {
    state = state.copyWith(password: password);
  }

  void validate(WidgetRef ref) {
    final authStatus = ref.watch(authProvider);
    
    if (users.contains(state.user) && passwords.contains(state.password)) {
      ref.read(authProvider.notifier).authenticate();
    } else {
      state.logger.i('Invalid username or password');
    }
  }
}

final loginProvider = StateNotifierProvider<LoginStateNotifier, LoginState>(
  (ref) => LoginStateNotifier(),
);

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        child: TextField(
                onChanged: (user) =>
                    ref.read(storeUser(user)),
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                
          },
          child: TextField(
                onChanged: (password) =>
                    ref.read(storePassword(password)),
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
          },
          ElevatedButton(
            onPressed: () {
              ref.read(loginProvider.notifier).validate();
              Navigator.of(context).pushNamed('/home2');
            },
            child: Text('Login'),
        ),
      ),
    );
  }
}