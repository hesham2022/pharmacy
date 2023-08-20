import 'get_reviews_params.dart';

class GetPostParams extends PaginationParams {
  GetPostParams({required super.page, required super.limit, required String id})
      : super(options: {'pharmacy': id});
}
