import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realtime_video_stream_task/core/routing/app_router.dart';
import 'package:realtime_video_stream_task/core/theming/colors.dart';
import 'package:realtime_video_stream_task/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: kPrimaryColor),
          useMaterial3: true,
          textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
          primaryColor: kPrimaryColor,
        ),
        title: 'Realtime Video Stream',
      ),
    );
  }
}
