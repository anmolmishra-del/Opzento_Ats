// application_details_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/my_appliation_detail.dart/state/detail_state.dart';

class ApplicationDetailsCubit
    extends Cubit<ApplicationDetailsState> {

  ApplicationDetailsCubit()
      : super(
          ApplicationDetailsState.initial(),
        );

  void changeTab(int index) {
    emit(
      state.copyWith(
        selectedTab: index,
      ),
    );
  }
}