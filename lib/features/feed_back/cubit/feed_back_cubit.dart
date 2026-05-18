import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/feed_back/state/feed_back_state.dart';

class InterviewFeedbackCubit extends Cubit<InterviewFeedbackState> {
  InterviewFeedbackCubit() : super(InterviewFeedbackState());

  void changeTab(int index) {
    emit(state.copyWith(selectedTab: index));
  }

  void setRating(int round, String type, int value) {
    if (type == "overall") {
      final map = {...state.overallRating};
      map[round] = value;
      emit(state.copyWith(overallRating: map));
    }

    if (type == "tech") {
      final map = {...state.technical};
      map[round] = value;
      emit(state.copyWith(technical: map));
    }

    if (type == "communication") {
      final map = {...state.communication};
      map[round] = value;
      emit(state.copyWith(communication: map));
    }

    if (type == "problem") {
      final map = {...state.problemSolving};
      map[round] = value;
      emit(state.copyWith(problemSolving: map));
    }
  }

  void setRemark(int round, String value) {
    final map = {...state.remarks};
    map[round] = value;
    emit(state.copyWith(remarks: map));
  }

  void setComment(int round, String value) {
    final map = {...state.comments};
    map[round] = value;
    emit(state.copyWith(comments: map));
  }

  Future<void> submit(int round) async {
    emit(state.copyWith(isSubmitting: true));

    await Future.delayed(const Duration(seconds: 1)); // API CALL

    emit(state.copyWith(isSubmitting: false, success: true));
  }
}