import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/jobs/model/model_class.dart';
import 'package:opsento_ats/features/my_applications/cubit/my_application_cubit.dart';
import 'package:opsento_ats/features/my_applications/presentaion/my_appication_page.dart';
import 'create_job.dart';

class CreateJobdetailsPage extends StatelessWidget {
  final JobData job;
  final bool isRecruiter;

  const CreateJobdetailsPage({
    super.key,
    required this.job,
    required this.isRecruiter,
  });

  Color _getPriorityColor(String priority) {
    final lower = priority.toLowerCase().trim();
    if (lower.contains('very high') || lower == '0' || lower == 'high') return const Color(0xFFEF4444); // Red
    if (lower.contains('medium') || lower == '1') return const Color(0xFFF59E0B); // Amber
    return const Color(0xFF10B981); // Emerald Green
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor(job.priority);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Premium Slate Background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          "Job Details",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w900,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF0F172A),
              size: 20,
            ),
          ),
        ),
      ),
      // bottomNavigationBar: SafeArea(
      //   child: Container(
      //     padding: const EdgeInsets.all(20),
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      //       boxShadow: [
      //         BoxShadow(
      //           color: const Color(0xFF0F172A).withOpacity(0.06),
      //           blurRadius: 20,
      //           offset: const Offset(0, -8),
      //         ),
      //       ],
      //     ),
      //     child: isRecruiter
      //         // RECRUITER ACTIONS
      //         ? Row(
      //             children: [
      //               Expanded(
      //                 child: ElevatedButton.icon(
      //                   onPressed: () {
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                         builder: (_) => const RecruitmentCreatePage(),
      //                       ),
      //                     );
      //                   },
      //                   icon: const Icon(Icons.edit_rounded, size: 20, color: Colors.white),
      //                   label: const Text(
      //                     "Edit Job",
      //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      //                   ),
      //                   style: ElevatedButton.styleFrom(
      //                     backgroundColor: const Color(0xFF4F46E5), // Indigo
      //                     elevation: 0,
      //                     minimumSize: const Size(double.infinity, 54),
      //                     shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(16),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(width: 16),
      //               Expanded(
      //                 child: OutlinedButton.icon(
      //                   onPressed: () => Navigator.pop(context),
      //                   icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFFEF4444)),
      //                   label: const Text(
      //                     "Close Job",
      //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFEF4444)),
      //                   ),
      //                   style: OutlinedButton.styleFrom(
      //                     foregroundColor: const Color(0xFFEF4444),
      //                     side: const BorderSide(color: Color(0xFFFCA5A5), width: 1.5),
      //                     minimumSize: const Size(double.infinity, 54),
      //                     shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(16),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           )
      //         // CANDIDATE APPLY NOW
      //         : ElevatedButton.icon(
      //             onPressed: () {
      //               final cubit = context.read<MyApplicationCubit>();
      //               cubit.applyJob(
      //                 title: job.title,
      //                 company: job.department,
      //                 type: job.type,
      //                 experience: job.experience,
      //                 location: job.location,
      //                 salary: job.salary,
      //                 candidateName: 'Shankar',
      //                 status: job.status,
      //               );
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (_) => const MyApplicationPage(),
      //                 ),
      //               );
      //             },
      //             icon: const Icon(Icons.send_rounded, size: 20, color: Colors.white),
      //             label: const Text(
      //               "Apply Now",
      //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
      //             ),
      //             style: ElevatedButton.styleFrom(
      //               backgroundColor: const Color(0xFF4F46E5),
      //               elevation: 0,
      //               minimumSize: const Size(double.infinity, 56),
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(16),
      //               ),
      //             ),
      //           ),
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌟 TOP JOB IDENTITY CARD
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEEF2FF), Color(0xFFF5F3FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4F46E5).withOpacity(0.06),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.business_center_rounded,
                          color: Color(0xFF4F46E5),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              job.department,
                              style: const TextStyle(
                                color: Color(0xFF4F46E5),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Color(0xFFE2E8F0), height: 1),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 16,
                    runSpacing: 10,
                    children: [
                      _rowInfo(Icons.history_rounded, job.experience.isEmpty ? 'Not Spec' : job.experience),
                      _rowInfo(Icons.monetization_on_outlined, job.salary.isEmpty ? 'N/A' : job.salary),
                      _rowInfo(Icons.location_on_rounded, job.location.isEmpty ? 'N/A' : job.location),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      // Published Badge
                      _pillBadge(
                        icon: job.isPublished ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                        text: job.isPublished ? 'Published' : 'Draft',
                        bgColor: job.isPublished ? const Color(0xFFECFDF5) : const Color(0xFFF1F5F9),
                        textColor: job.isPublished ? const Color(0xFF047857) : const Color(0xFF475569),
                      ),
                      // Priority Badge
                      _pillBadge(
                        icon: Icons.star_rounded,
                        text: "${job.priority} Priority",
                        bgColor: priorityColor.withOpacity(0.08),
                        textColor: priorityColor,
                      ),
                      // Status Badge
                      _pillBadge(
                        icon: Icons.info_outline_rounded,
                        text: job.status,
                        bgColor: const Color(0xFFEFF6FF),
                        textColor: const Color(0xFF1D4ED8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 🌟 PRIMARY SKILLS PANEL
            if (job.primarySkills.isNotEmpty) ...[
              _sectionTitle("Primary Skills Required"),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.primarySkills.map((s) {
                  return _tagChip(s, const Color(0xFF4F46E5), const Color(0xFFEEF2FF));
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],

            // 🌟 SECONDARY SKILLS PANEL
            if (job.secondarySkills.isNotEmpty) ...[
              _sectionTitle("Secondary Skills Required"),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: job.secondarySkills.map((s) {
                  return _tagChip(s, const Color(0xFFD97706), const Color(0xFFFFFBEB));
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],

            // 🌟 JOB DESCRIPTION CARD
            if (job.description.trim().isNotEmpty) ...[
              _sectionTitle("Job Description"),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: _buildRichDescriptionText(job.description),
              ),
              const SizedBox(height: 24),
            ],

            // 🌟 RESPONSIBILITIES PANEL
            if (job.responsibilities.isNotEmpty) ...[
              _sectionTitle("Key Responsibilities"),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: job.responsibilities.map((r) => _bulletPoint(r)).toList(),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // 🌟 REQUIREMENTS PANEL
            if (job.requirements.isNotEmpty) ...[
              _sectionTitle("Minimum Requirements"),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: job.requirements.map((req) => _bulletPoint(req)).toList(),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // 🌟 JOB METADATA SUMMARY DETAILS CARDS
            _sectionTitle("Job Directory Summary"),
            const SizedBox(height: 12),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _metadataCard(Icons.apartment_rounded, "Department", job.department)),
                  const SizedBox(width: 14),
                  Expanded(child: _metadataCard(Icons.work_history_rounded, "Experience Required", job.experience.isEmpty ? 'Not specified' : job.experience)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _metadataCard(Icons.payments_rounded, "Budget / Salary", job.salary.isEmpty ? 'Not specified' : job.salary)),
                  const SizedBox(width: 14),
                  Expanded(child: _metadataCard(Icons.access_time_filled_rounded, "Employment Type", job.type.isEmpty ? 'Full-time' : job.type)),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _rowInfo(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF64748B), size: 16),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _pillBadge({
    required IconData icon,
    required String text,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: textColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tagChip(String label, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: textColor.withOpacity(0.1)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _bulletPoint(String text) {
    final trimmed = text.trim();
    String cleanLine = trimmed;
    if (trimmed.startsWith('•') || trimmed.startsWith('-') || trimmed.startsWith('*')) {
      cleanLine = trimmed.substring(1).trim();
    }

    final colonIndex = cleanLine.indexOf(':');
    final hasColon = colonIndex > 0 && colonIndex < 35;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF4F46E5),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: hasColon
                ? RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Color(0xFF475569),
                      ),
                      children: [
                        TextSpan(
                          text: cleanLine.substring(0, colonIndex + 1),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(
                          text: cleanLine.substring(colonIndex + 1),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    cleanLine,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF475569),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _metadataCard(IconData icon, String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF4F46E5), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRichDescriptionText(String text) {
    final lines = text.split('\n');
    final List<Widget> children = [];

    for (var line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        children.add(const SizedBox(height: 10));
        continue;
      }

      // Check if it's a bullet point
      bool isBullet = trimmed.startsWith('•') || trimmed.startsWith('-') || trimmed.startsWith('*');
      String cleanLine = trimmed;
      if (isBullet) {
        cleanLine = trimmed.substring(1).trim();
      }

      // Check for colon
      final colonIndex = cleanLine.indexOf(':');
      if (colonIndex > 0 && colonIndex < 35) {
        final prefix = cleanLine.substring(0, colonIndex + 1);
        final suffix = cleanLine.substring(colonIndex + 1);

        children.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isBullet) ...[
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 10),
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4F46E5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.6,
                        color: Color(0xFF475569),
                      ),
                      children: [
                        TextSpan(
                          text: prefix,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        TextSpan(
                          text: suffix,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        children.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isBullet) ...[
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 10),
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4F46E5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
                Expanded(
                  child: Text(
                    cleanLine,
                    style: const TextStyle(
                      fontSize: 14.5,
                      height: 1.6,
                      color: Color(0xFF475569),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
