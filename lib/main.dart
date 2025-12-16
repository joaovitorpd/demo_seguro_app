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
import 'app/utils/log_utils.dart';

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
        ? ReCaptchaV3Provider('0038FE67-CE9D-4C89-8E77-9446E323E617')
        : ReCaptchaV3Provider('6Le0LnQrAAAAAKimXiDH9lwRd88utqkQYAhpyi2k'),
  );

  // Garantir que obtemos um token App Check válido antes de inicializar Auth
  try {
    await FirebaseAppCheck.instance.getToken();
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.getIdToken(true);
    }
  } catch (e) {
    safePrint('App Check token error: $e');
    // Em produção, considere colocar App Check em monitor mode se precisar debugar.
  }

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
    safePrint('Error ao ler keep_logged no storage: $e');
    await storage.delete(key: 'keep_logged');
    keep = false;
  }

  runApp(
    ProviderScope(
      overrides: [rememberMeProvider.overrideWith((_) => keep)],
      child: ModularApp(module: AppModule(), child: const AppWidget()),
    ),
  );
}
