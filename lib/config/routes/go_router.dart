import 'package:carpass/config/routes/router_notifier.dart';
import 'package:carpass/features/auth/code_verification.dart';
import 'package:carpass/features/auth/login.dart';
import 'package:carpass/features/auth/sign_up.dart';
import 'package:carpass/features/report/vehicle-list/vehicle_list.dart';
import 'package:carpass/features/report/vehicle-view/vehicle_view.dart';
import 'package:carpass/models/auth/auth.dart';
import 'package:carpass/theme/bottomNavbar/bottom_navbar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

var mainRouter = Provider((ref) {
  final notifier = ref.read(goRouternotifierProvider);

  return GoRouter(
    redirectLimit: 20,
    initialLocation: '/auth',
    refreshListenable: notifier,
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => SwipBottomNavbarComponent(),
      ),
      GoRoute(
        path: '/vehicle',
        builder: (context, state) => const VehicleList(),
        routes: [
          GoRoute(
            path: 'view/:id',
            builder: (context, state) => VehicleView(
              id: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: 'signup',
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            path: 'verify',
            builder: (context, state) => const CodeVerification(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authstatus = notifier.authStatus;

      if (authstatus == AuthStatus.verified) {
        return '/auth/verify';
      }

      if (authstatus == AuthStatus.checking ||
          authstatus == AuthStatus.unauthenticated) {
        return '/auth';
      }
      if (authstatus == AuthStatus.authenticated &&
          isGoingTo.contains('/auth')) {
        return '/home';
      }

      return isGoingTo;
    },
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Ops! Aún estamos en desarrollo :)'),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/form');
                },
                child: const Text('Ir a Formularios'),
              )
            ],
          ),
        ),
      );
    },
  );
});
