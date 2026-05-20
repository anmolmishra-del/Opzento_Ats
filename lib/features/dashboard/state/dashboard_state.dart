class DashboardState {
  final bool isLoading;
  final String? error;

  final String selectedFilter;

  final List<String> titles;
  final List<int> counts;
  final List<double> chartValues;

  const DashboardState({
    required this.isLoading,
    required this.error,
    required this.selectedFilter,
    required this.titles,
    required this.counts,
    required this.chartValues,
  });

  factory DashboardState.initial() {
    return const DashboardState(
      isLoading: false,
      error: null,
      selectedFilter: "This Month",
      titles: [
        "Open Positions",
        "New Applications",
        "Interviews Today",
        "Offers Pending",
        "Hired This Month",
        "Rejected",
      ],
      counts: [24, 128, 8, 5, 12, 18],
      chartValues: [120, 70, 80, 60, 75],
    );
  }

  DashboardState copyWith({
    bool? isLoading,
    String? error,
    String? selectedFilter,
    List<String>? titles,
    List<int>? counts,
    List<double>? chartValues,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      titles: titles ?? this.titles,
      counts: counts ?? this.counts,
      chartValues: chartValues ?? this.chartValues,
    );
  }
}