import 'package:ttn_flix/di/service_locator.dart';
import 'package:ttn_flix/generated/l10n.dart';
import 'package:ttn_flix/home/model/ttnflix_movies.dart';
import 'package:ttn_flix/network/ttnflix_api_client.dart';
import 'package:ttn_flix/network/ttnflix_api_url.dart';

class TtnflixHomeRepository {
  final TtnflixApiClient _apiService;

  TtnflixHomeRepository() : _apiService = SL.get<TtnflixApiClient>();

  Future<TtnflixMoviesModel> getHomePageDate(int? pageNo) async {
    final response = await _apiService.getHomeDataApi(
        endpoint: TtnflixApiUrl.getMovieList,
        converter: TtnflixMoviesModel.fromJson,
        queryParams:{S.current.page: pageNo});
    return response;
  }
}