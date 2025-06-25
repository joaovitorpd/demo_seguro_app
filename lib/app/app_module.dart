import 'package:flutter_modular/flutter_modular.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module('/', module: AuthModule());
    r.module('/home', module: HomeModule());
  }
}
