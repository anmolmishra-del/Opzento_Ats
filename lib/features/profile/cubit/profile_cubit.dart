import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/core/services/api_service.dart';
import 'package:opsento_ats/features/profile/state/profile_state.dart';

class RecruiterProfileCubit
    extends Cubit<RecruiterProfileState> {

  RecruiterProfileCubit()
      : super(
          RecruiterProfileState.initial(),
        ) {

    getProfile();
  }

  final service = OdooService();

  // GET PROFILE
  Future<void> getProfile() async {

    try {

      final response =
          await service.getProfile();

      print(response);

      final data = response[0];

      emit(
        state.copyWith(

          name:
              data['name'] ?? "",

          email:
              data['email'] ?? "",

          phone:
              data['phone'] ?? "",

          role:
              "Recruiter",

          location:
              "",

          memberSince:
              data['create_date'] ?? "",

          company:
              data['company_id'] != null
                  ? data['company_id'][1]
                  : "",

          designation:
              "",

          website:
              "",
        ),
      );

    } catch (e) {

      print(e);
    }
  }

  // UPDATE PROFILE
  void updateProfile({

    required String name,
    required String role,
    required String email,
    required String phone,
    required String location,

  }) {

    emit(
      state.copyWith(

        name: name,

        role: role,

        email: email,

        phone: phone,

        location: location,
      ),
    );
  }
}