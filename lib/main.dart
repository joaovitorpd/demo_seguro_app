import 'package:demo_seguro_app/app/modules/auth/providers/auth_provider.dart';
import 'package:demo_seguro_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
      synchronizable: true,
    ),
  );
  final keep = (await storage.read(key: 'keep_logged')) == 'true';

  final user = FirebaseAuth.instance.currentUser;
  if (!keep && user != null) {
    await FirebaseAuth.instance.signOut();
  }

  if (!keep && FirebaseAuth.instance.currentUser != null) {
    await FirebaseAuth.instance.signOut();
  }

  runApp(
    ProviderScope(
      overrides: [rememberMeProvider.overrideWith((_) => keep)],
      child: ModularApp(module: AppModule(), child: const AppWidget()),
    ),
  );
}
