import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../helper/helper.dart';
import '../../blocs/movie/movie_bloc.dart';

class SearchMainPage extends StatefulWidget {
  const SearchMainPage({super.key});

  @override
  State<SearchMainPage> createState() => _SearchMainPageState();
}

class _SearchMainPageState extends State<SearchMainPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.px),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50.px,
              child: TextField(
                controller: controller,
                onChanged: (value) {
                  context.read<MovieBloc>().add(GetMovieSearchEvent(keyWord: value));
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      )
                  ),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      context.read<MovieBloc>().add(GetMovieSearchEvent(keyWord: ''));
                      controller.clear();
                    },
                    child: Icon(Icons.close),
                  ),
                  contentPadding: EdgeInsets.only(bottom: 10.px)
                ),
              ),
            ),
          )
        ],
      ),
      drawer: Helper().defaultDrawer(context, 'search'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal:20.px),
        children: [
          SizedBox(height: 20.px,),
          Text(
            'Search Result',
            style: TextStyle(
              fontSize: 18.px,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 20.px,),
          BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state.searchStatus is SearchMovieSuccess) {
                return Wrap(
                  runSpacing: 10.px,
                  spacing: 20.px,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    for (int i = 0; i < (state.searchMovieResponse!.results ?? []).length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          context.read<MovieBloc>().add(GetMovieTrailerEvent(id: state.searchMovieResponse!.results![i].id ?? 0));
                          Helper().modalForMovieDetail(
                            context: context,
                            description: state.searchMovieResponse!.results![i].overview ?? '',
                            title: state.searchMovieResponse!.results![i].title ?? '',
                          );
                        },
                        child: SizedBox(
                          height: 230.px,
                          width: (size.width * 0.5 - 10.px) - 20.px,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.px)),
                                child: CachedNetworkImage(
                                  imageUrl: 'https://image.tmdb.org/t/p/original/${state.searchMovieResponse!.results![i].posterPath}',
                                  width: (size.width * 0.5 - 10.px) - 20.px,
                                  height: 230.px,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.px,
                                      right: 10.px,
                                      top: 20.px
                                  ),
                                  child: Text(
                                    state.searchMovieResponse!.results![i].title ?? '',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.px
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ],
                );
              }

              return Container();
            },
          )
        ],
      ),
    );
  }
}
