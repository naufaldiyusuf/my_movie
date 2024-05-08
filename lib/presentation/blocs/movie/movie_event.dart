part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetLatestMovieList extends MovieEvent {}

class GetPopularMovieList extends MovieEvent {}

class GetMovieTrailerEvent extends MovieEvent {
  final int id;

  const GetMovieTrailerEvent({required this.id});
}

class GetMovieSearchEvent extends MovieEvent {
  final String keyWord;

  const GetMovieSearchEvent({required this.keyWord});
}

class GetActionMovieList extends MovieEvent {}