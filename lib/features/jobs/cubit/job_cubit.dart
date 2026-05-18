import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/job_state.dart';

class JobCubit extends Cubit<JobState> {
  JobCubit() : super(JobState.initial());

  void changeTab(String tab) {
    emit(state.copyWith(selectedTab: tab));
  }

  void search(String value) {
    emit(state.copyWith(searchQuery: value));
  }
    void addJob(JobData job) {
final updatedJobs = List<JobData>.from(state.jobs)
  ..insert(0, job);
    emit(state.copyWith(jobs: updatedJobs));
  }
}
