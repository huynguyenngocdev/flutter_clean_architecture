import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/core/models/constants.dart';
import 'package:flutter_clean_architecture/src/modules/home/presentation/home_screen/home_screen.dart';
import 'package:flutter_clean_architecture/src/modules/splash/splash.dart';

enum Routes { splash, home, login }

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.login: _Paths.login,
    Routes.home: _Paths.home,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case _Paths.home:
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}

class NavSlideCustom extends PageRouteBuilder {
  final Widget child;
  Direction direction;
  NavSlideCustom({required this.child, this.direction = Direction.none})
      : super(
          transitionDuration: const Duration(milliseconds: 0),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  Tween<Offset> getPosition() {
    switch (direction) {
      case Direction.left:
        return Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        );
      case Direction.right:
        return Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        );
      case Direction.top:
        return Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        );
      case Direction.bottom:
        return Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        );
      default:
        Tween<Offset>(
          begin: Offset.zero,
          end: Offset.zero,
        );
    }
    return Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
        position: getPosition().animate(animation), child: child);
  }
}
