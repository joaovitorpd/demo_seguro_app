import 'package:demo_seguro_app/app/modules/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const backgroundColor = Color.fromARGB(255, 30, 30, 40);
    const actionCollor = Color.fromARGB(255, 40, 111, 99);
    const textCollor = Colors.white;
    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        children: [
          SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.all(16),
            color: backgroundColor,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Olá!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  color: backgroundColor,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textCollor,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              iconAlignment: IconAlignment.end,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Minha Conta",
                                style: TextStyle(color: actionCollor),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          _actionRow(
            label: "Home / Seguros",
            textCollor: textCollor,
            icon: Icons.settings,
            actionCollor: actionCollor,
            onPressed: () {},
          ),
          _actionRow(
            label: "Minhas Contratações",
            textCollor: textCollor,
            icon: Icons.settings,
            actionCollor: actionCollor,
            onPressed: () {},
          ),
          _actionRow(
            label: "Meus Sinistros",
            textCollor: textCollor,
            icon: Icons.settings,
            actionCollor: actionCollor,
            onPressed: () {},
          ),
          _actionRow(
            label: "Minha Família",
            textCollor: textCollor,
            icon: Icons.settings,
            actionCollor: actionCollor,
            onPressed: () {},
          ),
          _actionRow(
            label: "Meus Bens",
            textCollor: textCollor,
            icon: Icons.settings,
            actionCollor: actionCollor,
            onPressed: () {},
          ),
          _actionRow(
            label: "Pagamentos",
            textCollor: textCollor,
            icon: Icons.settings,
            actionCollor: actionCollor,
            onPressed: () {},
          ),
          _actionRow(
            label: "Coberturas",
            textCollor: textCollor,
            icon: Icons.settings,
            actionCollor: actionCollor,
            onPressed: () {},
          ),
          _actionRow(
            label: "Validar Boleto",
            textCollor: textCollor,
            icon: Icons.settings,
            actionCollor: actionCollor,
            onPressed: () {},
          ),
          _actionRow(
            label: "Telefones Importantes",
            textCollor: textCollor,
            icon: Icons.settings,
            actionCollor: actionCollor,
            onPressed: () {},
          ),
          _actionRow(
            label: "Configurações",
            textCollor: textCollor,
            actionCollor: actionCollor,
            icon: Icons.settings,
            onPressed: () {},
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () async {
                  await ref.read(authProvider.notifier).logout();
                  Modular.to.navigate('/');
                },
                child: Text(
                  "Sair",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: actionCollor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _actionRow({
  required String label,
  required Color textCollor,
  required IconData? icon,
  required Color actionCollor,
  required Function()? onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: actionCollor),
        TextButton(
          onPressed: onPressed,
          child: Text(label, style: TextStyle(color: textCollor)),
        ),
      ],
    ),
  );
}
