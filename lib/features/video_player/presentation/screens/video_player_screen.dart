import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_video_stream_task/core/theming/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import '../manager/video_player_cubit/video_player_cubit.dart';
import '../manager/video_player_cubit/video_player_state.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoSourceType sourceType;
  final String videoUrl;

  const VideoPlayerScreen({
    super.key,
    required this.sourceType,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController? ytController;
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();

    final cubit = context.read<VideoPlayerCubit>();

    if (widget.sourceType == VideoSourceType.youtube) {
      final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl)!;
      ytController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );

      ytController!.addListener(() {
        cubit.sendStatus(ytController!.value.isPlaying ? "playing" : "paused");
      });
    } else {
      videoController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..initialize().then((_) {
          setState(() {});
          videoController!.addListener(() {
            cubit.sendStatus(
                videoController!.value.isPlaying ? "playing" : "paused");
          });
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(title: const Text("Video Player")),
      body: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
          if (isLandscape) {
            return Center(child: _buildPlayer(state));
          }
          return Column(
            children: [
              _buildPlayer(state),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  state.isConnected ? "Connected" : "Disconnected",
                  style: TextStyle(
                    color: state.isConnected ? kGreenColor : kRedColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text("Likes: ${state.likeCount}"),

              if (state.message != null)
                Text(
                  state.message!,
                  style: const TextStyle(color: kGreenColor),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayer(VideoPlayerState state) {
    if (state.sourceType == VideoSourceType.youtube) {
      return YoutubePlayer(
        controller: ytController!,
        showVideoProgressIndicator: true,
      );
    }

    if (videoController != null && videoController!.value.isInitialized) {
      return Stack(
        children: [
          AspectRatio(
            aspectRatio: videoController!.value.aspectRatio,
            child: VideoPlayer(videoController!),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: Icon(
                color: kWhiteColor,
                size: 50,
                videoController!.value.isPlaying
                    ? Icons.pause_circle_filled_rounded
                    : Icons.play_arrow_rounded,
              ),
              onPressed: () {
                setState(() {
                  if (videoController!.value.isPlaying) {
                    videoController!.pause();
                  } else {
                    videoController!.play();
                  }
                });
              },
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        const SizedBox(height: 32),
        const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  @override
  void dispose() {
    ytController?.dispose();
    videoController?.dispose();
    super.dispose();
  }
}
