<<<<<<< HEAD
import 'dart:typed_data';

=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
class OfferLetterState {
  final String package;
  final String reportingTo;
  final String location;
  final String joiningDate;

  final bool isGenerated;
  final String offerText;
<<<<<<< HEAD
  final Uint8List? offerPdfBytes;
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc

  OfferLetterState({
    this.package = "",
    this.reportingTo = "",
    this.location = "",
    this.joiningDate = "",
    this.isGenerated = false,
    this.offerText = "",
<<<<<<< HEAD
    this.offerPdfBytes,
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
  });

  OfferLetterState copyWith({
    String? package,
    String? reportingTo,
    String? location,
    String? joiningDate,
    bool? isGenerated,
    String? offerText,
<<<<<<< HEAD
    Uint8List? offerPdfBytes,
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
  }) {
    return OfferLetterState(
      package: package ?? this.package,
      reportingTo: reportingTo ?? this.reportingTo,
      location: location ?? this.location,
      joiningDate: joiningDate ?? this.joiningDate,
      isGenerated: isGenerated ?? this.isGenerated,
      offerText: offerText ?? this.offerText,
<<<<<<< HEAD
      offerPdfBytes: offerPdfBytes ?? this.offerPdfBytes,
=======
>>>>>>> 43cbe6ce7c2264bbdaaea6a51ab7beb043056dcc
    );
  }
}