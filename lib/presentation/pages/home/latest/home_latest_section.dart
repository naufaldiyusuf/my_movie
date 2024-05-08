part of 'components/home_latest_library.dart';

class HomeLatestSection extends StatelessWidget {
  final double marginBetweenOuter;
  const HomeLatestSection({
    super.key,
    required this.marginBetweenOuter
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.latestStatus is LatestMovieSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Latest',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.px
                ),
              ),
              SizedBox(height: 15.px,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 110.px,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 0; i < (state.latestMovieResponse!.results ?? []).length; i++) ...[
                      GestureDetector(
                        onTap: () {
                          context.read<MovieBloc>().add(GetMovieTrailerEvent(id: state.latestMovieResponse!.results![i].id ?? 0));
                          Helper().modalForMovieDetail(
                            context: context,
                            description: state.latestMovieResponse!.results![i].overview ?? '',
                            title: state.latestMovieResponse!.results![i].title ?? ''
                          );
                        },
                        child: SizedBox(
                          height: 110.px,
                          width: (size.width * 0.5 - marginBetweenOuter) - 10.px,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10.px)),
                                child: CachedNetworkImage(
                                  imageUrl: "https://image.tmdb.org/t/p/original/${state.latestMovieResponse!.results![i].posterPath}",
                                  height: 110.px,
                                  width: (size.width * 0.5 - marginBetweenOuter) - 10.px,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10.px, left: 8.px, right: 8.px),
                                  child: Text(
                                    state.latestMovieResponse!.results![i].title ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.red
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (i != state.latestMovieResponse!.results!.length - 1) ...[
                        SizedBox(width: 20.px,)
                      ]
                    ],
                  ],
                ),
              )
            ],
          );
        }

        return Container();
      },
    );
  }
}
