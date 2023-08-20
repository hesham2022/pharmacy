import '../../modeules/User/auth/domain/entities/get_reviews_params.dart';

class SearchParams extends PaginationParams {
  SearchParams(
      {required super.page, required super.limit, required String search})
      : super(options: {'q': search});
}
