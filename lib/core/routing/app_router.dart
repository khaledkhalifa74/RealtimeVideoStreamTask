import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_video_stream_task/core/routing/routes.dart';
import 'package:realtime_video_stream_task/features/home/presentation/screens/home_screen.dart';
import 'package:realtime_video_stream_task/features/video/presentation/screens/video_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
class AppRouter {
  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.homeScreen,
    routes: [
      GoRoute(
        path: Routes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.videoScreen,
        builder: (context, state) {
          // final args = state.extra as Map<String, dynamic>?;
          return VideoScreen(
            // receiverId: args?['receiverId'] as String?,
          );
        },
      ),
    ],
  );
}