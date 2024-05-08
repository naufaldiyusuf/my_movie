part of 'components/home_action_library.dart';

class HomeActionSection extends StatelessWidget {
  final double marginBetweenOuter;
  const HomeActionSection({
    super.key,
    required this.marginBetweenOuter
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.actionStatus is ActionMovieSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Action',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.px
                ),
              ),
              SizedBox(height: 15.px,),
              SizedBox(
                height: 230.px,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  children: [
                    for (int i = 0; i < (state.actionMovieResponse!.results ?? []).length; i++) ...[
                      SizedBox(
                        height: 230.px,
                        width: (size.width * 0.5 - 10.px) - 10.px,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: (size.width * 0.5 - 10.px) - 10.px,
                              height: 230.px,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.px)),
                                child: CachedNetworkImage(
                                  imageUrl: 'https://image.tmdb.org/t/p/original/${state.actionMovieResponse!.results![i].posterPath}',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) {
                                    return Container();
                                  },
                                  errorWidget: (context, url, error) {
                                    return Container();
                                  },
                                  fadeInDuration: const Duration(
                                      milliseconds: 500),
                                  fadeInCurve: Curves.easeIn,
                                ),
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
                                  state.actionMovieResponse!.results![i].title ?? '',
                                  style: TextStyle(
                                    color: Colors.red
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (i != state.actionMovieResponse!.results!.length - 1) ...[
                        SizedBox(width: 20.px,)
                      ]
                    ]
                  ],
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }
}
