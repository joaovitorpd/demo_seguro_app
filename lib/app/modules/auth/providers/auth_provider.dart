import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final rememberMeProvider = StateProvider<bool>((_) => false);

class AuthNotifier extends StateNotifier<User?> {
  final FirebaseAuth _auth;
  final FlutterSecureStorage _storage;

  AuthNotifier()
    : _auth = FirebaseAuth.instance,
      _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        webOptions: WebOptions(),
      ),
      super(null) {
    _auth.authStateChanges().listen((user) {
      state = user;
    });
  }

  Future<void> login(String cpf, String password, bool remember) async {
    final rawCpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    final email = '$rawCpf@app.com';
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    if (remember) {
      await _storage.write(key: 'keep_logged', value: 'true');
    } else {
      await _storage.delete(key: 'keep_logged');
    }
  }

  Future<void> register(String cpf, String password) async {
    final email = '$cpf@app.com';
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _storage.delete(key: 'keep_logged');
    await _auth.signOut();
  }

  String get cpfUnmasked {
    final email = state?.email ?? '';
    final raw = email.split('@').first;
    return raw.replaceAllMapped(
      RegExp(r'^(\d{3})(\d{3})(\d{3})(\d{2})$'),
      (m) => '${m[1]}.${m[2]}.${m[3]}-${m[4]}',
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
final authStateChangesProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);
