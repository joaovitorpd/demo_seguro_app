import 'package:demo_seguro_app/app/core/widgets/text_field_roud_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/validators/cpf_validator.dart';
import '../../../core/widgets/cpf_text_field.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final cpfController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    cpfController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    final rawCpf = cpfController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final password = passwordController.text;
    final confirm = confirmPasswordController.text;

    if (!CPFValidator.isValid(rawCpf)) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('CPF inválido')));
      return;
    }

    if (password.length < 6) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha deve ter ao menos 6 caracteres')),
      );
      return;
    }

    if (password != confirm) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('As senhas não conferem')));
      return;
    }

    try {
      await ref.read(authProvider.notifier).register(rawCpf, password);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
      Modular.to.navigate('/home/');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: ${e.toString()}')));
    }
  }

  void _hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => _hideKeyboard(context),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.yellow],
                        begin: const FractionalOffset(0.0, 0.5),
                        end: const FractionalOffset(1.5, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    color: Color.fromARGB(255, 30, 30, 38),
                  ),
                ],
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 350,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 40, 40, 40),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: Column(
                            children: [
                              SizedBox(height: 16.0),
                              CpfTextField(
                                controller: cpfController,
                                autofocus: true,
                              ),
                              const SizedBox(height: 16),
                              TextFieldRoudBorder(
                                controller: passwordController,
                                obscureText: true,
                                labelText: 'Senha',
                              ),
                              const SizedBox(height: 16),
                              TextFieldRoudBorder(
                                controller: confirmPasswordController,
                                obscureText: true,
                                labelText: 'Confirmar Senha',
                              ),
                              const SizedBox(height: 24),
                              TextButton(
                                onPressed: register,
                                child: const Text(
                                  'Cadastrar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Modular.to.pop(),
                                child: const Text(
                                  'Voltar para o login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
