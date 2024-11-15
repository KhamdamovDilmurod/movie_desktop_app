import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_desktop_app/pages/home/home_page.dart';
import 'package:movie_desktop_app/repository/movie_repository.dart';
import 'package:movie_desktop_app/services/api_service.dart';
import 'package:movie_desktop_app/services/database_service.dart';
import 'package:window_manager/window_manager.dart';


import 'bloc/movie_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize window manager
  // await windowManager.ensureInitialized();
  //
  // // Configure window options
  // WindowOptions windowOptions = const WindowOptions(
  //   size: Size(1280, 720),
  //   center: true,
  //   backgroundColor: Colors.transparent,
  //   skipTaskbar: false,
  //   titleBarStyle: TitleBarStyle.normal,
  //   title: 'Movie Desktop App',
  //   minimumSize: Size(800, 600),  // Prevents window from being too small
  // );
  //
  // await windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   await windowManager.show();
  //   await windowManager.focus();
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MovieBloc(
          repository: MovieRepository(
            apiService: MovieApiService(),
            databaseService: MovieDatabaseService(),
          ),
        )..add(LoadMovies())),
      ],
      child: MaterialApp(
        title: 'Movie Desktop App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
        home: const HomePage(),
      ),
    );
  }
}