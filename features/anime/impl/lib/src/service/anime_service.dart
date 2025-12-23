import 'package:anime_impl/src/service/data/anime_details_dto.dart';
import 'package:anime_impl/src/service/data/anime_search_request_model.dart';
import 'package:anime_impl/src/service/data/api_response_model.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AnimeService {
  static const searchAnimeEndpoint = '/top/anime';

  static const animeDetailEndPoint = '/anime/{:id}/full';

  final _dio = Dio(BaseOptions(baseUrl: 'https://api.jikan.moe/v4'))
    ..interceptors.add(PrettyDioLogger(responseBody: false));

  Future<AnimeResponseModel> searchAnime(AnimeSearchRequest request) async {
    final res = await _dio.get(
      searchAnimeEndpoint,
      queryParameters: request.toQueryParams(),
    );
    return AnimeResponseModel.fromJson(res.data);
  }

  Future<AnimeDetailDto> getAnimeDetailById(int id) async {
    final res = await _dio.get(
      animeDetailEndPoint.replaceAll('{:id}', id.toString()),
    );

    return AnimeDetailDto.fromJson(res.data);
  }
}
