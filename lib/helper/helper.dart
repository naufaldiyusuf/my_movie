import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/blocs/movie/movie_bloc.dart';
import 'package:my_movie/presentation/pages/home/home_main_page.dart';
import 'package:my_movie/presentation/pages/home/latest/components/home_latest_library.dart';
import 'package:my_movie/presentation/pages/search/search_main_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Helper {
  void modalForMovieDetail({required BuildContext context, required String description, required String title}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
      ),
      builder: (_) {
        VideoPlayerController? _controller;
        YoutubePlayerController? _youtubeController;
        String url = 'https://www.youtube.com/watch?v=zw0JHV7nrUg';

        // if (url.toLowerCase().contains('youtube')) {
        //   String videoId = YoutubePlayer.convertUrlToId(url) ?? '';
        //   _youtubeController = YoutubePlayerController(
        //     initialVideoId: videoId,
        //     flags: const YoutubePlayerFlags(
        //       autoPlay: true,
        //       mute: false,
        //     ),
        //   );
        // } else {
        //   _controller = VideoPlayerController.networkUrl(Uri.parse(
        //       url))
        //     ..initialize().then((value) {
        //     });
        // }

        return Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
          padding: EdgeInsets.symmetric(horizontal: 20.px),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.px,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 28.px,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.px,),
              BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state.trailerStatus is MovieTrailerSuccess && state.movieTrailerResponse!.results != null && state.movieTrailerResponse!.results!.isNotEmpty) {
                      if ((state.movieTrailerResponse!.results![0].site ?? '').toLowerCase() == 'youtube') {
                        String videoId = YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=${state.movieTrailerResponse!.results![0].key}') ?? '';
                        _youtubeController = YoutubePlayerController(
                          initialVideoId: videoId,
                          flags: const YoutubePlayerFlags(
                            autoPlay: true,
                            mute: false,
                          ),
                        );
                      } else {
                        _controller = VideoPlayerController.networkUrl(Uri.parse(
                            'https://vimeo.com/${state.movieTrailerResponse!.results![0].key}'))
                          ..initialize().then((value) {
                          });
                      }

                      return Expanded(
                        child: ListView(
                          children: [
                            url.toLowerCase().contains('youtube')
                                ? _youtubeController != null
                                ? YoutubePlayer(
                              controller: _youtubeController!,
                              liveUIColor: Colors.amber,
                            ) : Container()
                                : _controller != null ?GestureDetector(
                              onTap: () {
                                _controller!.value.isPlaying
                                    ? _controller!.pause()
                                    : _controller!.play();
                              },
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width * 0.7,
                                  child: VideoPlayer(_controller!)
                              ),
                            ) : Container(),
                            SizedBox(height: 20.px,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.px),
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontSize: 20.px,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            SizedBox(height: 20.px,),
                            Text(
                              description,
                              style: TextStyle(
                                  fontSize: 16.px,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 20.px,),
                            HomeLatestSection(marginBetweenOuter: 20.px),
                            SizedBox(height: 30.px,)
                          ],
                        ),
                      );
                    }

                    return Container();
                  }
              )
            ],
          ),
        );
      },
    );
  }

  Drawer defaultDrawer(BuildContext context, String className) {
    return Drawer(
      child: SafeArea(
        top: true,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(height: 30.px,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.movie_creation_outlined,
                  size: 100.px,
                ),
                Text(
                  'My Movie',
                  style: TextStyle(
                    fontSize: 20.px,
                    fontWeight: FontWeight.w700
                  ),
                )
              ],
            ),
            SizedBox(height: 30.px,),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => HomeMainPage()),
                  (route) => false,
                );
              },
            ),
            ListTile(
              title: const Text('Search'),
              onTap: () {
                Navigator.pop(context);
                if (className != 'search') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SearchMainPage())
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}