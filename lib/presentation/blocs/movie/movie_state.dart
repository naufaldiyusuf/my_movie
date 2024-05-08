part of 'movie_bloc.dart';

class MovieState extends Equatable {
  final MovieListResponseModel? latestMovieResponse;
  final MovieListResponseModel? popularMovieResponse;
  final MovieTrailerResponseModel? movieTrailerResponse;
  final MovieListResponseModel? searchMovieResponse;
  final MovieListResponseModel? actionMovieResponse;
  final MovieStatus latestStatus;
  final MovieStatus popularStatus;
  final MovieStatus trailerStatus;
  final MovieStatus searchStatus;
  final MovieStatus actionStatus;

  const MovieState({
    this.latestMovieResponse,
    this.popularMovieResponse,
    this.movieTrailerResponse,
    this.searchMovieResponse,
    this.actionMovieResponse,
    this.latestStatus = const LatestMovieInitial(),
    this.popularStatus = const PopularMovieInitial(),
    this.trailerStatus = const MovieTrailerInitial(),
    this.searchStatus = const SearchMovieInitial(),
    this.actionStatus = const ActionMovieInitial(),
  });

  MovieState copyWith({
    MovieListResponseModel? latestMovieResponse,
    MovieListResponseModel? popularMovieResponse,
    MovieTrailerResponseModel? movieTrailerResponse,
    MovieListResponseModel? searchMovieResponse,
    MovieListResponseModel? actionMovieResponse,
    MovieStatus? latestStatus,
    MovieStatus? popularStatus,
    MovieStatus? trailerStatus,
    MovieStatus? searchStatus,
    MovieStatus? actionStatus,
  }) => MovieState(
    latestMovieResponse: latestMovieResponse ?? this.latestMovieResponse,
    popularMovieResponse: popularMovieResponse ?? this.popularMovieResponse,
    movieTrailerResponse: movieTrailerResponse ?? this.movieTrailerResponse,
    searchMovieResponse: searchMovieResponse ?? this.searchMovieResponse,
    actionMovieResponse: actionMovieResponse ?? this.actionMovieResponse,
    latestStatus: latestStatus ?? this.latestStatus,
    popularStatus: popularStatus ?? this.popularStatus,
    trailerStatus: trailerStatus ?? this.trailerStatus,
    searchStatus: searchStatus ?? this.searchStatus,
    actionStatus: actionStatus ?? this.actionStatus,
  );

  @override
  List<Object?> get props=> [
    latestMovieResponse,
    popularMovieResponse,
    movieTrailerResponse,
    searchMovieResponse,
    actionMovieResponse,
    latestStatus,
    popularStatus,
    trailerStatus,
    searchStatus,
    actionStatus,
  ];
}

abstract class MovieStatus {
  const MovieStatus();
}

class LatestMovieInitial extends MovieStatus {
  const LatestMovieInitial();
}

class LatestMovieLoading extends LatestMovieInitial {}

class LatestMovieSuccess extends LatestMovieInitial {}

class LatestMovieFailed extends LatestMovieInitial {}

class PopularMovieInitial extends MovieStatus {
  const PopularMovieInitial();
}

class PopularMovieLoading extends PopularMovieInitial {}

class PopularMovieSuccess extends PopularMovieInitial {}

class PopularMovieFailed extends PopularMovieInitial {}

class MovieTrailerInitial extends MovieStatus {
  const MovieTrailerInitial();
}

class MovieTrailerLoading extends MovieTrailerInitial {}

class MovieTrailerSuccess extends MovieTrailerInitial {}

class MovieTrailerFailed extends MovieTrailerInitial {}

class SearchMovieInitial extends MovieStatus {
  const SearchMovieInitial();
}

class SearchMovieLoading extends SearchMovieInitial {}

class SearchMovieSuccess extends SearchMovieInitial {}

class SearchMovieFailed extends SearchMovieInitial {}

class ActionMovieInitial extends MovieStatus {
  const ActionMovieInitial();
}

class ActionMovieLoading extends ActionMovieInitial {}

class ActionMovieSuccess extends ActionMovieInitial {}

class ActionMovieFailed extends ActionMovieInitial {}