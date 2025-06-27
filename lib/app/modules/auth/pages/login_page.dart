import 'package:demo_seguro_app/app/core/widgets/cpf_text_field.dart';
import 'package:demo_seguro_app/app/core/widgets/text_field_roud_border.dart';
import 'package:demo_seguro_app/app/modules/auth/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/validators/cpf_validator.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final cpfController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() async {
    final cpf = cpfController.text;
    if (!CPFValidator.isValid(cpf)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('CPF inválido')));
      return;
    }

    try {
      //final rawCpf = cpfController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final remember = ref.read(rememberMeProvider);
      await ref
          .read(authProvider.notifier)
          .login(cpf, passwordController.text, remember);
      Modular.to.navigate('/home/');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  void _hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    cpfController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rememberState = ref.watch(rememberMeProvider);
    const containerColor = Color.fromARGB(255, 40, 40, 40);
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => _hideKeyboard(context),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _background(),
              _centralContainer(
                containerColor: containerColor,
                rememberState: rememberState,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _background() {
    return Column(
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
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: kIsWeb
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/generic_logo.png",
                      scale: 2,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "SEGURADORA",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "SEGURADORA",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: kIsWeb
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Text(
                      "Bem vindo!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: kIsWeb
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        "Aqui você gerencia seus seguros e de seus familiares em poucos cliques!",
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        _bottomBackground(),
      ],
    );
  }

  Widget _bottomBackground() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 30, 30, 38),
      child: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(50, 220, 50, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/generic_logo.png",
              scale: 2,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(
              "Acesse através das redes sociais",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Image.asset("assets/social_media_logos.png", height: 50),
          ],
        ),
      ),
    );
  }

  Widget _centralContainer({
    required Color containerColor,
    required bool rememberState,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 300,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: _login,
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Modular.to.pushNamed('/register'),
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Column(
                    children: [
                      SizedBox(height: 16.0),
                      CpfTextField(controller: cpfController),
                      SizedBox(height: 16.0),
                      TextFieldRoudBorder(
                        controller: passwordController,
                        labelText: 'Senha',
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _login(),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox.adaptive(
                            value: rememberState,
                            onChanged: (v) =>
                                ref.read(rememberMeProvider.notifier).state =
                                    v ?? false,
                            checkColor: Colors.white,
                            activeColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                              (_) => const BorderSide(color: Colors.white),
                            ),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                          const Expanded(
                            child: Text(
                              'Lembrar sempre',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Esqueceu a senha?',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -25,
          child: GestureDetector(
            onTap: _login,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(color: containerColor, width: 6),
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.yellow],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
