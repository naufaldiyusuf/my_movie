part of 'components/home_carousel_library.dart';

class HomeCarouselSection extends StatefulWidget {
  const HomeCarouselSection({super.key});

  @override
  State<HomeCarouselSection> createState() => _HomeCarouselSectionState();
}

class _HomeCarouselSectionState extends State<HomeCarouselSection> {
  int carouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.popularStatus is PopularMovieSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    height: 160.px,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        carouselIndex = index;
                      });
                    }
                ),
                items: [
                  if (state.popularMovieResponse!.results != null) ...[
                    for (int i = 0; i < 4; i++) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.px),
                        child: GestureDetector(
                          onTap: () {
                            context.read<MovieBloc>().add(GetMovieTrailerEvent(id: state.popularMovieResponse!.results![i].id ?? 0));
                            Helper().modalForMovieDetail(
                              context: context,
                              description: state.popularMovieResponse!.results![i].overview ?? '',
                              title: state.popularMovieResponse!.results![i].title ?? '',
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10.px)),
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/original/${state.popularMovieResponse!.results![i].posterPath}',
                              width: MediaQuery.of(context).size.width,
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
                      )
                    ]
                  ]
                ],
              ),
              SizedBox(height: 10.px,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 4; i++) ...[
                    Container(
                      height: 5.px,
                      width: 5.px,
                      decoration: ShapeDecoration(
                          color: carouselIndex == i ? Colors.black : Colors.grey,
                          shape: OvalBorder()
                      ),
                    ),
                    if (i != 3) ...[
                      SizedBox(width: 10.px,),
                    ]
                  ]
                ],
              ),
            ],
          );
        }

        return Container();
      }
    );
  }
}
