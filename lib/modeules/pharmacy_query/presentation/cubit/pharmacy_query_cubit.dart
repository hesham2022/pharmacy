import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pharmacy_query_state.dart';

class PharmacyQueryCubit extends Cubit<PharmacyQueryState> {
  PharmacyQueryCubit() : super(PharmacyQueryInitial());
}
