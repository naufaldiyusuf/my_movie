import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/blocs/movie/movie_bloc.dart';
import 'package:my_movie/presentation/pages/home/home_main_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return const MyApp();
      },
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: [],
    //   child: MaterialApp(
    //     title: 'My Movie',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //       useMaterial3: true,
    //     ),
    //     home: const HotelMainPage(),
    //   ),
    // );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MovieBloc())
      ],
      child: MaterialApp(
        title: 'My Movie',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeMainPage(),
      ),
    );
  }
}
