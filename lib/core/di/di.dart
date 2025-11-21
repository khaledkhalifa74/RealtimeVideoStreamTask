import 'package:get_it/get_it.dart';
import 'package:realtime_video_stream_task/features/video_player/data/data_sources/video_remote_data_source.dart';
import 'package:realtime_video_stream_task/features/video_player/data/repositories/video_repository.dart';

final di = GetIt.instance;

Future<void> initDi() async {
  di.registerLazySingleton<VideoRemoteDataSource>(() => VideoRemoteDataSource());

  di.registerLazySingleton<VideoRepository>(
        () => VideoRepository(di<VideoRemoteDataSource>()),
  );
}
