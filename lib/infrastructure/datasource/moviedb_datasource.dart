import 'package:cinemapedia/config/constansts/environment.dart';
import 'package:cinemapedia/domain/datasource/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/datasource/models/moviedb/moviedb_responde.dart';
import 'package:dio/dio.dart';

import '../mappers/movie_mapper.dart';

class MovieDbDataSource extends MoviesDataSource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',//aca ponemos el url base
    queryParameters: {
      'api_key': Environment.theMovieDbKey,//agregamos nuestra api key
      'language': 'es-MX'//cambiamos el lenguaje a espanhol
    }
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing');

    final movieDBResponse = MovieDbResponse.fromJson(response.data);
   
    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)).toList();


    return movies;
  }


}