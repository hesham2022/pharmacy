class PaginationParams {
  final int page;
  final int limit;

  PaginationParams({required this.page, required this.limit, this.options});

  PaginationParams copyWith({
    int? page,
    int? limit,
  }) {
    return PaginationParams(
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  final Map<String, dynamic>? options;
  Map<String, dynamic> toQuery({Map<String, dynamic>? query}) {
    final paginationQueru = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    if (query != null) paginationQueru.addAll(query);
    if (options != null) paginationQueru.addAll(options!);
    // delete null values
    paginationQueru.removeWhere((key, value) => value == null);

    return paginationQueru;
  }
}
