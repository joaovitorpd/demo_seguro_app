import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final List<DrawerItem> items = [
    DrawerItem(icon: Icons.settings, text: "Home / Seguros"),
    DrawerItem(icon: Icons.settings, text: "Minhas Contratações"),
    DrawerItem(icon: Icons.settings, text: "Meus Sinistros"),
    DrawerItem(icon: Icons.settings, text: "Minha Família"),
    DrawerItem(icon: Icons.settings, text: "Meus Bens"),
    DrawerItem(icon: Icons.settings, text: "Pagamentos"),
    DrawerItem(icon: Icons.settings, text: "Coberturas"),
    DrawerItem(icon: Icons.settings, text: "Validar Boleto"),
    DrawerItem(icon: Icons.settings, text: "Telefones Importantes"),
    DrawerItem(icon: Icons.settings, text: "Configurações"),
  ];

  HomeDrawer({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
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
                          color: Colors.blue,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
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

          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(items[index].icon, color: actionCollor),
                  title: Text(
                    items[index].text,
                    style: TextStyle(color: textCollor),
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Sair",
                textAlign: TextAlign.start,
                style: TextStyle(color: actionCollor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String text;

  DrawerItem({required this.icon, required this.text});
}
