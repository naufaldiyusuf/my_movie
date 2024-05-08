import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/domain/repositories/movie/movie_repository.dart';
import 'package:my_movie/helper/helper.dart';
import 'package:my_movie/presentation/pages/home/action/components/home_action_library.dart';
import 'package:my_movie/presentation/pages/home/carousel/components/home_carousel_library.dart';
import 'package:my_movie/presentation/pages/home/latest/components/home_latest_library.dart';
import 'package:my_movie/presentation/pages/search/search_main_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../blocs/movie/movie_bloc.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(GetPopularMovieList());
    context.read<MovieBloc>().add(GetLatestMovieList());
    context.read<MovieBloc>().add(GetActionMovieList());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('My Movie'),
        actions: [
          GestureDetector(
            onTap: () {
              context.read<MovieBloc>().add(GetMovieSearchEvent(keyWord: ''));

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SearchMainPage())
              );
            },
            child: Icon(
              Icons.search,
              size: 35.px,
            ),
          ),
          SizedBox(width: 20.px,)
        ],
      ),
      drawer: Helper().defaultDrawer(context, 'home'),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<MovieBloc>().add(GetPopularMovieList());
          context.read<MovieBloc>().add(GetLatestMovieList());
          context.read<MovieBloc>().add(GetActionMovieList());
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 30.px,),
            const HomeCarouselSection(),
            SizedBox(height: 40.px,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.px),
              child: HomeLatestSection(
                marginBetweenOuter: 10.px,
              ),
            ),
            SizedBox(height: 30.px,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.px),
              child: HomeActionSection(
                marginBetweenOuter: 10.px,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

