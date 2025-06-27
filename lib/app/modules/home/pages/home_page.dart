import 'package:demo_seguro_app/app/modules/auth/providers/auth_provider.dart';
import 'package:demo_seguro_app/app/modules/home/pages/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider.notifier);
    final cpf = auth.cpfUnmasked;
    const backgroundColor = Color.fromARGB(255, 30, 30, 40);
    const componentsCollor = Color.fromARGB(255, 45, 45, 60);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        iconTheme: IconThemeData(
          color: Colors.white, // Cor do ícone do Drawer
        ),
        backgroundColor: backgroundColor,
      ),
      drawer: Drawer(
        surfaceTintColor: Colors.white,
        child: HomeDrawer(name: cpf),
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // CPF
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.yellow],
                begin: const FractionalOffset(0.0, 0.5),
                end: const FractionalOffset(1.5, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Text(
              'Olá, CPF: $cpf',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Cotar e Contratar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Cotar e Contratar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _serviceCard(
                                icon: Icons.directions_car,
                                label: 'Automóvel',
                                componentsCollor: componentsCollor,
                                onTap: () {
                                  Modular.to.pushNamed(
                                    '/home/webview',
                                    arguments: {
                                      'url':
                                          'https://jsonplaceholder.typicode.com/',
                                      'title': 'Cotar Automóvel',
                                    },
                                  );
                                },
                              ),
                              _serviceCard(
                                icon: Icons.home,
                                label: 'Residência',
                                componentsCollor: componentsCollor,
                              ),
                              _serviceCard(
                                icon: Icons.favorite,
                                label: 'Vida',
                                componentsCollor: componentsCollor,
                              ),
                              _serviceCard(
                                icon: Icons.health_and_safety,
                                label: 'Acidentes Pessoais',
                                componentsCollor: componentsCollor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Minha Família
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Minha Família',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _featureCard(
                          icon: Icons.add_circle_outline_outlined,
                          descpitionText:
                              'Adicione aqui membros da sua família e compartilhe os seguros com eles',
                          context: context,
                          componentsCollor: componentsCollor,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Contratados
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Contratados',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _featureCard(
                          icon: Icons.sentiment_dissatisfied,
                          descpitionText:
                              'Você ainda possui seguros contratados',
                          context: context,
                          componentsCollor: componentsCollor,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceCard({
    required IconData icon,
    required String label,
    required Color? componentsCollor,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: componentsCollor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureCard({
    required BuildContext context,
    required IconData icon,
    required String descpitionText,
    required Color componentsCollor,
  }) {
    final width = MediaQuery.of(context).size.width - 32;

    return SizedBox(
      width: width,
      height: 200,
      child: Card(
        color: componentsCollor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                descpitionText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
