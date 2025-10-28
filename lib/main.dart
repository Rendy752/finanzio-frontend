import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finanzio/application/providers/auth_provider.dart';
import 'package:finanzio/presentation/screens/login_screen.dart';
import 'package:finanzio/presentation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(child: Finanzio()));
}

class Finanzio extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider);

    return MaterialApp(
      title: 'Finanzio',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: _getHome(authStatus),
    );
  }

  Widget _getHome(AuthStatus status) {
    switch (status) {
      case AuthStatus.authenticated:
        return HomeScreen();
      case AuthStatus.unauthenticated:
        return LoginScreen();
      case AuthStatus.unknown:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}
