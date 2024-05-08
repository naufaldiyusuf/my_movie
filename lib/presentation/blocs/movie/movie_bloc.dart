import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/data/models/movie/movie_list_response_model.dart';
import 'package:my_movie/data/models/movie/movie_trailer_response_model.dart';
import 'package:my_movie/domain/repositories/movie/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(const MovieState()) {
    on<GetLatestMovieList>((event, emit) async {
      emit(state.copyWith(
        latestStatus: LatestMovieLoading()
      ));

      final either = await MovieRepository().getLatestMovieList();

      emit(
        either.fold(
              (failure) => state.copyWith(
                latestStatus: LatestMovieFailed()
              ),
              (success) => state.copyWith(
                latestStatus: LatestMovieSuccess(),
                latestMovieResponse: success
              )
        )
      );
    });

    on<GetPopularMovieList>((event, emit) async {
      emit(state.copyWith(
        popularStatus: PopularMovieLoading()
      ));

      final either = await MovieRepository().getPopularMovieList();

      emit(
        either.fold(
              (failed) => state.copyWith(
                popularStatus: PopularMovieFailed()
              ),
              (success) => state.copyWith(
                popularStatus: PopularMovieSuccess(),
                popularMovieResponse: success
              ))
      );
    });

    on<GetMovieTrailerEvent>((event, emit) async {
      emit(state.copyWith(
        trailerStatus: MovieTrailerLoading()
      ));

      final either = await MovieRepository().getMovieTrailer(id: event.id);

      emit(
        either.fold(
              (failure) => state.copyWith(
                trailerStatus: MovieTrailerFailed()
              ),
              (success) => state.copyWith(
                trailerStatus: MovieTrailerSuccess(),
                movieTrailerResponse: success
              )
        )
      );
    });

    on<GetMovieSearchEvent>((event, emit) async {
      emit(state.copyWith(searchStatus: SearchMovieLoading()));

      final either = await MovieRepository().getSearchMovieList(keyWord: event.keyWord);

      emit(
        either.fold(
              (failure) => state.copyWith(
                searchStatus: SearchMovieFailed()
              ),
              (success) => state.copyWith(
                searchStatus: SearchMovieSuccess(),
                searchMovieResponse: success
              )
        )
      );
    });

    on<GetActionMovieList>((event, emit) async {
      emit(state.copyWith(
          actionStatus: ActionMovieLoading()
      ));

      final either = await MovieRepository().getActionMovieList();

      emit(
          either.fold(
                  (failure) => state.copyWith(
                  actionStatus: ActionMovieFailed()
              ),
                  (success) => state.copyWith(
                  actionStatus: ActionMovieSuccess(),
                  actionMovieResponse: success
              )
          )
      );
    });
  }
}