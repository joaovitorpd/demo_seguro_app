import 'package:demo_seguro_app/app/core/pages/web_view_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage());
    r.child(
      '/webview',
      child: (_) =>
          WebViewPage(url: r.args.data['url'], title: r.args.data['title']),
    );
  }
}
