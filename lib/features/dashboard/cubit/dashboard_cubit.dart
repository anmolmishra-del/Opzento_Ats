import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:opsento_ats/features/dashboard/repository/service.dart';

import '../state/dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit()
      : super(
          DashboardState.initial(),
        ) {
    print("DASHBOARD CUBIT CREATED");

    loadDashboard();
  }

  // final repository = DashboardRepository();

  void changeFilter(String value) {
    emit(
      state.copyWith(
        selectedFilter: value,
      ),
    );
  }

  Future<void> loadDashboard() async {
    print("LOAD DASHBOARD STARTED");

    emit(
      state.copyWith(
        isLoading: true,
        error: null,
      ),
    );

//     try {
//       final data =
//           await repository.getDashboardStats();

//       print("API DATA => $data");

//       final counts =
//           List<int>.from(
//         data['counts'] ?? [],
//       );

//       final chartValues =
//           List<double>.from(
//         (data['chartValues'] ?? [])
//             .map(
//               (e) => (e as num).toDouble(),
//             ),
//       );

//       print("COUNTS => $counts");

//       print(
//         "CHART VALUES => $chartValues",
//       );

//       // MAKE BOTH LISTS SAME LENGTH
//       while (chartValues.length <
//           counts.length) {
//         chartValues.add(0);
//       }

//       emit(
//         state.copyWith(
//           isLoading: false,

//           name:
//               data['recruiterName'] ??
//                   "",

//           counts: counts,

//           chartValues: chartValues,

//           error: null,
//         ),
//       );
// print(data);
// print(data['counts']);
// print(data['chartValues']);
//       print(
//         "STATE UPDATED SUCCESS",
//       );
//     } catch (e) {
//       print("DASHBOARD ERROR");

//       print(e);

//       emit(
//         state.copyWith(
//           isLoading: false,

//           error:
//               e.toString(),
//         ),
//       );
//     }
  }

  void refreshDashboard() {
    loadDashboard();
  }
}
