import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_movie/constant.dart';
import 'package:my_movie/data/models/movie/movie_trailer_response_model.dart';

import '../../../../common/error/failures.dart';
import '../../../models/movie/movie_list_response_model.dart';

class MovieRemoteDataSource {
  final dio = Dio();
  Future<Either<Failure, MovieListResponseModel>> getLatestMovieList() async {
    String url = "${Constant().baseUrl}/discover/movie?include_adult=false&sort_by=primary_release_date.desc&api_key=${Constant().apiKey}";

    try {
      final response = await dio.get(url);

      final json = MovieListResponseModel.fromJson(response.data);

      return Right(json);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        return const Left(TimeOutFailure());
      } else if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure());
      } else {
        return const Left(ServerFailure());
      }
    }
  }

  Future<Either<Failure, MovieListResponseModel>> getPopularMovieList() async {
    String url = "${Constant().baseUrl}/discover/movie?include_adult=false&sort_by=popularity.desc&api_key=${Constant().apiKey}";

    try {
      final response = await dio.get(url);

      final json = MovieListResponseModel.fromJson(response.data);

      return Right(json);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        return const Left(TimeOutFailure());
      } else if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure());
      } else {
        return const Left(ServerFailure());
      }
    }
  }

  Future<Either<Failure, MovieTrailerResponseModel>> getMovieTrailer({required int id}) async {
    String url = "${Constant().baseUrl}/movie/$id/videos?api_key=${Constant().apiKey}";

    try {
      final response = await dio.get(url);

      final json = MovieTrailerResponseModel.fromJson(response.data);

      return Right(json);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        return const Left(TimeOutFailure());
      } else if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure());
      } else {
        return const Left(ServerFailure());
      }
    }
  }

  Future<Either<Failure, MovieListResponseModel>> getSearchMovieList({required String keyWord}) async {
    String keyWordFilter = keyWord.replaceAll(' ', '+');
    String url = '';
    if (keyWordFilter.isNotEmpty) {
      url = "${Constant().baseUrl}/search/movie?query=$keyWordFilter&include_adult=false&api_key=${Constant().apiKey}";
    } else {
      url = "${Constant().baseUrl}/discover/movie?include_adult=false&sort_by=primary_release_date.desc&api_key=${Constant().apiKey}";
    }

    try {
      final response = await dio.get(url);

      final json = MovieListResponseModel.fromJson(response.data);

      return Right(json);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        return const Left(TimeOutFailure());
      } else if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure());
      } else {
        return const Left(ServerFailure());
      }
    }
  }

  Future<Either<Failure, MovieListResponseModel>> getActionMovieList() async {
    String url = "${Constant().baseUrl}/discover/movie?include_adult=false&sort_by=popularity.desc&with_genres=28&api_key=${Constant().apiKey}";

    try {
      final response = await dio.get(url);

      final json = MovieListResponseModel.fromJson(response.data);

      return Right(json);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        return const Left(TimeOutFailure());
      } else if (e.type == DioExceptionType.connectionError) {
        return const Left(ConnectionFailure());
      } else {
        return const Left(ServerFailure());
      }
    }
  }
}