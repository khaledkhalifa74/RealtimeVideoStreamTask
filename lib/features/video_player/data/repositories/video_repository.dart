import '../data_sources/video_remote_data_source.dart';

class VideoRepository {
  final VideoRemoteDataSource remote;

  VideoRepository(this.remote);

  void connectToSocket(Function(bool) onConnectionChange) {
    remote.connectSocket(onConnectionChange: onConnectionChange);
  }

  void sendPlaybackStatus(String status) {
    remote.sendEvent("playback_status", {"status": status});
  }

  void listenForLikes(Function(dynamic) onLikeUpdate) {
    remote.onEvent("like_update", onLikeUpdate);
  }

  void listenForViewers(Function(dynamic) onViewerJoin) {
    remote.onEvent("viewer_joined", onViewerJoin);
  }

  void disconnect() => remote.disconnect();
}
