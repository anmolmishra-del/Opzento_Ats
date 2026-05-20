class ProfileState {
  final bool loading;
  final String? pdfUrl;
  final bool isShortlisted;
  final bool isRejected;

  const ProfileState({
    this.loading = false,
    this.pdfUrl,
    this.isShortlisted = false,
    this.isRejected = false,
  });

  ProfileState copyWith({
    bool? loading,
    String? pdfUrl,
    bool? isShortlisted,
    bool? isRejected,
  }) {
    return ProfileState(
      loading: loading ?? this.loading,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      isShortlisted: isShortlisted ?? this.isShortlisted,
      isRejected: isRejected ?? this.isRejected,
    );
  }
}