import 'package:demo_seguro_app/app/core/core_module.dart';
import 'package:demo_seguro_app/app/modules/auth/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.module('/', module: AuthModule());
    r.module('/home', module: HomeModule());
  }
}
