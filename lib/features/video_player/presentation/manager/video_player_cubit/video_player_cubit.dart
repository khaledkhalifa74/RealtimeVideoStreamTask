import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_player_state.dart';
import '../../../data/repositories/video_repository.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final VideoRepository repository;

  VideoPlayerCubit({
    required this.repository,
    required VideoSourceType sourceType,
    required String videoUrl,
  }) : super(
    VideoPlayerState(
      sourceType: sourceType,
      videoUrl: videoUrl,
      isConnected: false,
    ),
  );

  void safeEmit(VideoPlayerState newState) {
    if (!isClosed) emit(newState);
  }
  void init() {
    /// Connect socket
    repository.connectToSocket((connected) {
      safeEmit(state.copyWith(isConnected: connected));
    });

    /// Likes
    repository.listenForLikes((data) {
      if (!isClosed) {
        safeEmit(state.copyWith(likeCount: data["count"]));
      }
    });

    /// Viewer joined
    repository.listenForViewers((data) {
      safeEmit(state.copyWith(message: "${data['username']} joined"));
      Future.delayed(const Duration(seconds: 2), () {
        safeEmit(state.copyWith(message: null));
      });
    });
  }

  void sendStatus(String status) {
    repository.sendPlaybackStatus(status);
  }

  @override
  Future<void> close() {
    repository.removeListeners();
    repository.disconnect();
    return super.close();
  }
}
