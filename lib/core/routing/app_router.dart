import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:realtime_video_stream_task/core/di/di.dart';
import 'package:realtime_video_stream_task/core/routing/routes.dart';
import 'package:realtime_video_stream_task/features/home/presentation/screens/home_screen.dart';
import 'package:realtime_video_stream_task/features/video_player/data/repositories/video_repository.dart';
import 'package:realtime_video_stream_task/features/video_player/presentation/screens/video_player_screen.dart';
import '../../features/video_player/presentation/manager/video_player_cubit/video_player_cubit.dart';
import '../../features/video_player/presentation/manager/video_player_cubit/video_player_state.dart';

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
        path: Routes.videoPlayerScreen,
        builder: (context, state) {
          final typeString = state.uri.queryParameters["type"];
          final videoUrl = state.uri.queryParameters["url"] ?? "";

          final sourceType = typeString == "youtube"
              ? VideoSourceType.youtube
              : VideoSourceType.server;

          return BlocProvider(
            create: (_) => VideoPlayerCubit(
              repository: di<VideoRepository>(),
              sourceType: sourceType,
              videoUrl: videoUrl,
            )..init(),
            child: VideoPlayerScreen(
              sourceType: sourceType,
              videoUrl: videoUrl,
            ),
          );
        },
      ),
    ],
  );
}
