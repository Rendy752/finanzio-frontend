import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finanzio/application/providers/auth_provider.dart';
import 'package:finanzio/presentation/screens/login_screen.dart';
import 'package:finanzio/presentation/screens/main_navigation_screen.dart'; // <-- IMPORT BARU
import 'package:shared_preferences/shared_preferences.dart';

// Inisialisasi Riverpod's ProviderContainer di level root
late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Diperlukan untuk inisialisasi SharedPreferences
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    // ProviderScope diperlukan untuk menggunakan Riverpod
    ProviderScope(child: FinanzioApp()),
  );
}

class FinanzioApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider);

    return MaterialApp(
      title: 'Finanzio App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: _getHome(authStatus),
    );
  }

  Widget _getHome(AuthStatus status) {
    switch (status) {
      case AuthStatus.authenticated:
        return MainNavigationScreen();
      case AuthStatus.unauthenticated:
        return LoginScreen();
      case AuthStatus.unknown:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}
