import 'package:flutter/material.dart';
import 'package:opsento_ats/utils/shared_ref.dart';
import 'package:opsento_ats/routes/app_routes.dart';
import 'package:opsento_ats/features/candidatefolder/candidate/presentaion/candidate_page.dart';
import 'package:opsento_ats/features/dashboard/presentaion/dashboard_page.dart';
import 'package:opsento_ats/features/interview_feedback/presentaion/interview_feedback_page.dart';
import 'package:opsento_ats/features/jobs/presentaion/job_page.dart';
import 'package:opsento_ats/features/offer_approv/presetion/offere_screen.dart';

class RecruiterMainLayout extends StatefulWidget {
  const RecruiterMainLayout({super.key});

  @override
  State<RecruiterMainLayout> createState() => _RecruiterMainLayoutState();
}

class _RecruiterMainLayoutState extends State<RecruiterMainLayout> {
  int currentIndex = 0;
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    _checkAuth();
    
    // Initialize pages here to ensure they're created fresh
    pages = [
      DashboardPage(),
      JobPage(isRecruiter: true),
      CandidatePage(),
      OfferApprovalPage(),
      InterviewFeedbackPage(),
    ];
  }

  Future<void> _checkAuth() async {
    final prefs = SharedPref();
    final isLoggedIn = await prefs.getBool('isLoggedIn') ?? false;
    if (!isLoggedIn) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (route) => false,
        );
      }
    }
  }



  final List<_NavItem> navItems = const [
    _NavItem(icon: Icons.home_rounded, activeIcon: Icons.home_rounded, label: "Home"),
    _NavItem(icon: Icons.work_outline_rounded, activeIcon: Icons.work_rounded, label: "Jobs"),
    _NavItem(icon: Icons.people_outline_rounded, activeIcon: Icons.people_rounded, label: "Candidates"),
    _NavItem(icon: Icons.verified_outlined, activeIcon: Icons.verified_rounded, label: "Approval"),
    _NavItem(icon: Icons.rate_review_outlined, activeIcon: Icons.rate_review_rounded, label: "Feedback"),
  ];

  void onTabChanged(int index) {
    print("[DEBUG] RecruiterMainLayout: Tab changed from $currentIndex to $index");
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          navItems.length,
          (index) => _buildNavItem(index),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = navItems[index];
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTabChanged(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.indigo.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with animated color
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                isSelected ? item.activeIcon : item.icon,
                key: ValueKey(isSelected),
                size: 24,
                color: isSelected ? Colors.indigo : Colors.grey.shade400,
              ),
            ),

            // Animated label — only shown when selected
            AnimatedSize(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeInOut,
              child: isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        item.label,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.indigo,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
