import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/offer_later/state/offer_later_state.dart';

class OfferLetterCubit extends Cubit<OfferLetterState> {
  OfferLetterCubit() : super(OfferLetterState());

  void setPackage(String value) {
    emit(state.copyWith(package: value));
  }

  void setReporting(String value) {
    emit(state.copyWith(reportingTo: value));
  }

  void setLocation(String value) {
    emit(state.copyWith(location: value));
  }

  void setJoiningDate(String value) {
    emit(state.copyWith(joiningDate: value));
  }

  void generateOffer() {
    final offer = """
🎉 OFFER LETTER

We are pleased to offer you the position.

Package: ${state.package}
Reporting To: ${state.reportingTo}
Location: ${state.location}
Joining Date: ${state.joiningDate}

We welcome you to our organization.
""";

    emit(state.copyWith(
      isGenerated: true,
      offerText: offer,
    ));
  }
}