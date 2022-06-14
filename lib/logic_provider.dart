import 'package:flutter/widgets.dart';
import 'package:gallery_app/logics/image_logic.dart';

class LogicProvider extends InheritedWidget {
  final ImageLogic imageLogic;

  const LogicProvider({
    Key? key,
    required this.imageLogic,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static LogicProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LogicProvider>();
  }
}
