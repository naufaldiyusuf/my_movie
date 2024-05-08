import 'package:dartz/dartz.dart';
import 'package:my_movie/data/datasources/remote/movie/movie_remote_data_source.dart';
import 'package:my_movie/data/models/movie/movie_trailer_response_model.dart';

import '../../../common/error/failures.dart';
import '../../../data/models/movie/movie_list_response_model.dart';

class MovieRepository {
  final remoteDataSource = MovieRemoteDataSource();

  Future<Either<Failure, MovieListResponseModel>> getLatestMovieList() async {
    final result = await remoteDataSource.getLatestMovieList();

    return result;
  }

  Future<Either<Failure, MovieListResponseModel>> getPopularMovieList() async {
    final result = await remoteDataSource.getPopularMovieList();

    return result;
  }

  Future<Either<Failure, MovieTrailerResponseModel>> getMovieTrailer({required int id}) async {
    final result = await remoteDataSource.getMovieTrailer(id: id);

    return result;
  }

  Future<Either<Failure, MovieListResponseModel>> getSearchMovieList({required String keyWord}) async {
    final result = await remoteDataSource.getSearchMovieList(keyWord: keyWord);

    return result;
  }

  Future<Either<Failure, MovieListResponseModel>> getActionMovieList() async {
    final result = await remoteDataSource.getActionMovieList();

    return result;
  }
}