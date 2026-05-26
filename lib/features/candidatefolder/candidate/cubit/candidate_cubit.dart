import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/candidate_state.dart';

class CandidateCubit extends Cubit<CandidateState> {
  CandidateCubit() : super(CandidateState.initial());

  void changeTab(String tab) {
    emit(state.copyWith(selectedTab: tab));
  }

  void search(String value) {
    emit(state.copyWith(searchQuery: value));
  }

  void moveCandidate(String name, String newStage) {
    final updated = state.candidates.map((c) {
      if (c.name == name) {
        return Candidate(
          name: c.name,
          role: c.role,
          stage: newStage,
        );
      }
      return c;
    }).toList();

    emit(state.copyWith(candidates: updated));
  }
}
