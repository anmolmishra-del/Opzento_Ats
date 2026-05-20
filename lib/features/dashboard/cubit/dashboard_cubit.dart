import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState.initial());

  void changeFilter(String value) {
    emit(state.copyWith(selectedFilter: value));
  }

  void refreshDashboard() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // simulate API call
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
        isLoading: false,
        chartValues: [90, 100, 60, 110, 80],
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: "Something went wrong",
      ));
    }
  }
}