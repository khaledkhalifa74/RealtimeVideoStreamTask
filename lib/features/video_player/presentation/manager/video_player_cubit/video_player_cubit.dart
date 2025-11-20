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

  void init() {
    /// Connect socket
    repository.connectToSocket((connected) {
      emit(state.copyWith(isConnected: connected));
    });

    /// Likes
    repository.listenForLikes((data) {
      emit(state.copyWith(likeCount: data["count"]));
    });

    /// Viewer joined
    repository.listenForViewers((data) {
      emit(state.copyWith(message: "${data['username']} joined"));
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(message: null));
      });
    });
  }

  void sendStatus(String status) {
    repository.sendPlaybackStatus(status);
  }

  @override
  Future<void> close() {
    repository.disconnect();
    return super.close();
  }
}
