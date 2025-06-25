import 'package:demo_seguro_app/app/modules/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void logout() async {
    await ref.read(authProvider.notifier).logout();

    if (!mounted) return; // ← security

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Desconectado com sucesso!')));
    Modular.to.navigate('/'); // Modular.to.pop()
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(child: Text('Bem-vindo, ${user?.email ?? ''}')),
      floatingActionButton: FloatingActionButton(
        onPressed: logout,
        child: const Icon(Icons.logout),
      ),
    );
  }
}
