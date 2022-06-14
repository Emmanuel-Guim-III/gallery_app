import 'package:flutter/material.dart';
import 'package:gallery_app/logic_provider.dart';
import 'package:gallery_app/logics/image_logic.dart';
import 'package:gallery_app/models/image_model.dart';
import 'package:gallery_app/pages/home_page.dart';
import 'package:gallery_app/page_routes.dart' as routes;
import 'package:gallery_app/pages/image_view.dart';
import 'package:gallery_app/services/image_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final imageService = ImageServiceImpl();

  final logicInjectedApp = LogicProvider(
    imageLogic: ImageLogicImpl(imageService),
    child: const MyHomePage(),
  );
  runApp(logicInjectedApp);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _getRoute,
    );
  }

  Route<MaterialPageRoute> _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case routes.imageView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ImageView(
            image: settings.arguments as ImageModel,
          ),
          fullscreenDialog: true,
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
          fullscreenDialog: true,
        );
    }
  }
}
