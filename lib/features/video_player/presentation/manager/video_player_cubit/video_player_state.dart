import 'package:equatable/equatable.dart';

enum VideoSourceType { youtube, server }

class VideoPlayerState extends Equatable {
  final VideoSourceType sourceType;
  final String videoUrl;
  final int likeCount;
  final String? message;
  final bool isConnected;

  const VideoPlayerState({
    required this.sourceType,
    required this.videoUrl,
    this.likeCount = 0,
    this.message,
    this.isConnected = false,
  });

  VideoPlayerState copyWith({
    VideoSourceType? sourceType,
    String? videoUrl,
    int? likeCount,
    String? message,
    bool? isConnected,
  }) {
    return VideoPlayerState(
      sourceType: sourceType ?? this.sourceType,
      videoUrl: videoUrl ?? this.videoUrl,
      likeCount: likeCount ?? this.likeCount,
      message: message,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object?> get props => [sourceType, videoUrl, likeCount, message, isConnected];
}
