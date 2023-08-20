import 'package:bloc/bloc.dart';
import 'package:chefaa/modeules/User/Home_Screen/search_cubit/state.dart';
import 'package:chefaa/modeules/User/auth/domain/usecases/get_near.dart';

import '../../../../core/utils/search_params.dart';


class SearchPharmaciesCubit extends Cubit<GetpharmaciesState> {
  SearchPharmaciesCubit({required this.searchPharmaciesU})
      : super(GetpharmaciesState(
          pharmacies: [],
          status: GetpharmaciesPharmacies.initial,
        ));
  final SearchPharmaciesU searchPharmaciesU;

  Future<void> search({
    required String search,
    bool isNew = false,
  }) async {
    if (isNew) {
      reset();
    }
    if (state.reached) {
      return;
    }
    emit(
      state.copyWith(
        status: GetpharmaciesPharmacies.loading,
        byCat: false,
      ),
    );
    final result = await searchPharmaciesU(
      SearchParams(
        page: state.page,
        limit: 10,
        search: search,
      ),
    );

    print(state.page);
    result.fold(
        (l) => emit(
              state.copyWith(
                status: GetpharmaciesPharmacies.error,
                error: l.toString(),
              ),
            ), (r) {
      print('totla pages ${r.totalPages}');
      print('current page ${state.page}');
      emit(
        state.copyWith(
          status: GetpharmaciesPharmacies.loaded,
          page: state.page + 1,
          reached: r.totalPages <= (state.page + 1),
          pharmacies: [...state.pharmacies, ...r.results],
        ),
      );
    });
  }

  // reset
  void reset() {
    emit(
      state.copyWith(
          status: GetpharmaciesPharmacies.initial, pharmacies: [], reached: false, page: 0),
    );
  }
}
