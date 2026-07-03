import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dialcalink/app/ui/screens/splash_screen.dart';
import 'package:dialcalink/core/database/drift/tables/devices_table.dart';
import 'package:dialcalink/core/identity/providers/device_identity_provider.dart';
import 'package:dialcalink/features/calls/presentation/screens/calls_screen.dart';
import 'package:dialcalink/features/client/presentation/screens/client_shell_screen.dart';
import 'package:dialcalink/features/gateway/presentation/screens/gateway_home_screen.dart';
import 'package:dialcalink/features/gateway/presentation/screens/gateway_pairing_qr_screen.dart';
import 'package:dialcalink/features/onboarding/presentation/screens/onboarding_gateway_setup_screen.dart';
import 'package:dialcalink/features/onboarding/presentation/screens/onboarding_pairing_scan_screen.dart';
import 'package:dialcalink/features/onboarding/presentation/screens/onboarding_permissions_screen.dart';
import 'package:dialcalink/features/onboarding/presentation/screens/onboarding_role_selection_screen.dart';
import 'package:dialcalink/features/onboarding/presentation/screens/onboarding_welcome_screen.dart';
import 'package:dialcalink/features/sms/presentation/screens/sms_conversation_screen.dart';
import 'package:dialcalink/features/sms/presentation/screens/sms_list_screen.dart';
import 'package:dialcalink/features/status/presentation/screens/status_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@riverpod
GoRouter appRouter(Ref ref) {
  final refreshNotifier = ValueNotifier<AsyncValue>(const AsyncLoading());
  ref.listen(localDeviceIdentityProvider, (_, next) {
    refreshNotifier.value = next;
  }, fireImmediately: true);
  ref.onDispose(() => refreshNotifier.dispose());

  return GoRouter(
    initialLocation: '/splash',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final identityAsync = ref.read(localDeviceIdentityProvider);
      final identity = identityAsync.valueOrNull;
      final currentLocation = state.matchedLocation;

      if (identityAsync.isLoading && identity == null) {
        if (currentLocation == '/splash' || currentLocation == '/') {
          return '/splash';
        }
        return null;
      }
      if (identity == null && !identityAsync.isLoading) {
        if (!currentLocation.startsWith('/onboarding')) {
          return '/onboarding/welcome';
        }
        return null;
      }
      if (identity != null) {
        if (currentLocation == '/splash' ||
            currentLocation == '/onboarding/welcome') {
          return identity.role == DeviceRole.gateway
              ? '/gateway/home'
              : '/client/sms';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        redirect: (context, state) {
          if (state.uri.path == '/onboarding' ||
              state.uri.path == '/onboarding/') {
            return '/onboarding/welcome';
          }
          return null;
        },
        routes: [
          GoRoute(
            path: 'welcome',
            builder: (context, state) => const OnboardingWelcomeScreen(),
          ),
          GoRoute(
            path: 'role-selection',
            builder: (context, state) => const OnboardingRoleSelectionScreen(),
          ),
          GoRoute(
            path: 'permissions/:role',
            builder: (context, state) {
              final role = state.pathParameters['role'] == 'gateway'
                  ? DeviceRole.gateway
                  : DeviceRole.client;
              return OnboardingPermissionsScreen(role: role);
            },
          ),
          GoRoute(
            path: 'gateway-setup',
            builder: (context, state) => const GatewaySetupScreen(),
          ),
          GoRoute(
            path: 'pairing-scan',
            builder: (context, state) => const PairingScanScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/gateway/home',
        builder: (context, state) => const GatewayHomeScreen(),
        routes: [
          GoRoute(
            path: 'pairing-qr',
            builder: (context, state) => const GatewayPairingQrScreen(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ClientShellScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/client/sms',
                builder: (context, state) => const SmsListScreen(),
                routes: [
                  GoRoute(
                    name: 'sms_conversation',
                    path: ':phoneNumber',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) {
                      final phone = state.pathParameters['phoneNumber'] ?? '';
                      return SmsConversationScreen(phoneNumber: phone);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/client/calls',
                builder: (context, state) => const CallsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/client/status',
                builder: (context, state) => const StatusScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/client/re-pair',
        builder: (context, state) => const PairingScanScreen(),
      ),
    ],
  );
}
