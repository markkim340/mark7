import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mark7/common/view/root_tab.dart';
import 'package:mark7/common/view/splash_screen.dart';
import 'package:mark7/restaurant/view/restaurant_detail_screen.dart';
import 'package:mark7/user/model/user_model.dart';
import 'package:mark7/user/provider/user_me_provider.dart';
import 'package:mark7/user/view/login_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (prev, next) {
      if (prev != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes {
    return [
      GoRoute(
        path: '/',
        name: RootTab.routeName,
        builder: (context, state) => const RootTab(),
        routes: [
          GoRoute(
            path: 'restaurant/:rid',
            name: RestaurantDetailScreen.routeName,
            builder: (context, state) => RestaurantDetailScreen(
              id: state.pathParameters['rid']!,
            ),
          )
        ],
      ),
      GoRoute(
        path: '/splash',
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),
    ];
  }

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  /// Splash screen redirect logic
  /// when the user starts the app, check if the user is logged in
  /// Check has token in secure storage
  /// and if the user is not logged in, redirect to the login screen or home screen
  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    final loggingIn = state.location == '/login';

    if (user == null) {
      return loggingIn ? null : '/login';
    }

    if (user is UserModel) {
      return loggingIn || state.location == '/splash' ? '/' : null;
    }

    if (user is UserModelError) {
      return !loggingIn ? '/login' : null;
    }

    return null;
  }
}
