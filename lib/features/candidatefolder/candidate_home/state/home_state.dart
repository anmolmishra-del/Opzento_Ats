import '../../../my_applications/state/my_appication_state.dart';

class CandidateHomeState {

  final List<ApplicationData> applications;

  const CandidateHomeState({
    required this.applications,
  });

  factory CandidateHomeState.initial() {

    return const CandidateHomeState(
      applications: [],
    );
  }

  CandidateHomeState copyWith({
    List<ApplicationData>? applications,
  }) {

    return CandidateHomeState(
      applications:
          applications ??
              this.applications,
    );
  }
}