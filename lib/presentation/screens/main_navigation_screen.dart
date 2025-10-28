import 'package:finanzio/presentation/screens/home_screen.dart';
import 'package:finanzio/presentation/screens/transaction_screen.dart';
import 'package:finanzio/presentation/screens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State Provider untuk mengelola index tab yang aktif
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

class MainNavigationScreen extends ConsumerWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    TransactionScreen(),
    WalletScreen(),
    const Center(child: Text("Halaman Budget & Debt")), // Placeholder
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      body: _screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Akun',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.paid), label: 'Lainnya'),
        ],
      ),
    );
  }
}
