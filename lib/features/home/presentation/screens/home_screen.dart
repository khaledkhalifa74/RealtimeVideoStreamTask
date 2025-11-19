import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_video_stream_task/core/theming/colors.dart';
import 'package:realtime_video_stream_task/core/theming/styles.dart';
import 'package:realtime_video_stream_task/features/home/presentation/screens/widgets/video_source_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Video Streaming App',
          style: Styles.textStyle24.copyWith(
            color: kPrimaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_outline_rounded,
              size: 100.sp,
              color: kPrimaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              'Choose Video Source',
              style: Styles.textStyle22.copyWith(
                color: kPrimaryColor
              ),
            ),
            const SizedBox(height: 32),
            VideoSourceButton(
              icon: Icons.youtube_searched_for,
              title: 'Play YouTube Video',
              subtitle: 'Stream from YouTube',
              color: kRedColor,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            VideoSourceButton(
              icon: Icons.cloud_download,
              title: 'Play Server Video',
              subtitle: 'Stream from server',
              color: kBlueColor,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}