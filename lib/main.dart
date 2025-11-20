import 'package:demo_seguro_app/app/modules/auth/providers/auth_provider.dart';
import 'package:demo_seguro_app/app/utils/platform_other_setup.dart';
import 'package:demo_seguro_app/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializePlatform();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseAppCheck.instance.activate(
    androidProvider: kDebugMode
        ? AndroidProvider.debug
        : AndroidProvider.playIntegrity,
    appleProvider: kDebugMode ? AppleProvider.debug : AppleProvider.appAttest,
    webProvider: kDebugMode
        ? ReCaptchaV3Provider(
            'a60e93b6-e30f-4497-8166-5793effde1c9',
          ) // Chave DEBUG
        : ReCaptchaV3Provider(
            '6Le0LnQrAAAAAKimXiDH9lwRd88utqkQYAhpyi2k',
          ), // Chave PROD
  );

  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
      synchronizable: true,
    ),
  );

  bool keep = false;
  try {
    keep = (await storage.read(key: 'keep_logged')) == 'true';
  } catch (e) {
    await storage.delete(key: 'keep_logged');
    keep = false;
  }

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
