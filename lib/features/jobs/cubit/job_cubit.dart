import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/jobs/model/model_class.dart';
import 'package:opsento_ats/features/jobs/repository/create_job_servic.dart';

import '../state/job_state.dart';

class JobCubit extends Cubit<JobState> {

  JobCubit() : super(JobState.initial());

  void changeTab(String tab) {
    emit(state.copyWith(selectedTab: tab));
  }

  void search(String value) {
    emit(state.copyWith(searchQuery: value));
  }

  void setJobs(List<JobData> jobs) {
    emit(state.copyWith(jobs: jobs));
  }

  void addJob(JobData job) {

    final updatedJobs = List<JobData>.from(state.jobs)
      ..insert(0, job);

    emit(state.copyWith(jobs: updatedJobs));
  }

  void updateJob(
    JobData oldJob,
    JobData newJob,
  ) {

    final updatedJobs = List<JobData>.from(state.jobs);

    int idx = -1;

    if (newJob.id != null) {

      idx = updatedJobs.indexWhere(
        (j) => j.id == newJob.id,
      );
    }

    // fallback to match by title+department if no id
    if (idx == -1) {

      idx = updatedJobs.indexWhere(
        (j) =>
            j.title == oldJob.title &&
            j.department == oldJob.department,
      );
    }

    if (idx != -1) {

      updatedJobs[idx] = newJob;

      emit(state.copyWith(
        jobs: updatedJobs,
      ));

    } else {

      updatedJobs.insert(0, newJob);

      emit(state.copyWith(
        jobs: updatedJobs,
      ));
    }
  }
}

class RecruitmentCubit
    extends Cubit<RecruitmentState> {

  final RecruitmentService service;

  RecruitmentCubit(this.service)
      : super(RecruitmentState.initial());

  Future<void> fetchRecruitments() async {

    emit(state.copyWith(
      loading: true,
    ));

    try {

      final data =
          await service.fetchRecruitments();

      emit(
        state.copyWith(
          recruitments: data,
          loading: false,
        ),
      );

    } catch (e) {

      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }
}