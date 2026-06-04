import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:opsento_ats/core/constants/app_colors.dart';
import 'package:opsento_ats/features/candidatefolder/candidate/cubit/candidate_cubit.dart';
import 'package:opsento_ats/features/candidatefolder/candidate/state/candidate_state.dart';
import 'package:opsento_ats/features/candidatefolder/candidate/state/hr_candidate_model.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/cubit/candidate_screen_cubit.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/presentaion/resume_page.dart';

class CandidateProfilePage extends StatefulWidget {
  const CandidateProfilePage({super.key});

  @override
  State<CandidateProfilePage> createState() => _CandidateProfilePageState();
}

class _CandidateProfilePageState extends State<CandidateProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Inline Skills Mapper State
  String selectedSkillType = '';
  String skillName = '';
  String skillLevel = 'Intermediate';
  final TextEditingController skillNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    skillNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: BlocBuilder<CandidateCubit, CandidateState>(
        builder: (context, parentState) {
          print("[DEBUG] CandidateProfilePage BlocBuilder rebuilt. Selected candidate: ${parentState.selectedCandidate?.fullName}, Total candidates: ${parentState.candidates.length}");
          
          final candCubit = context.read<CandidateCubit>();
          // Safely fallback if selectedCandidate is null
          final candidate = parentState.selectedCandidate ?? parentState.candidates.first;
          
          print("[DEBUG] Displaying profile for: ${candidate.fullName} (${candidate.emailFrom})");
          
          final double percentage = candidate.matchingSkillPercentage;
          Color matchColor = Colors.orange;
          if (percentage >= 70) {
            matchColor = AppColors.success;
          } else if (percentage >= 40) matchColor = AppColors.primary;

          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A)),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                "Candidate Profile",
                style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18),
              ),
              // actions: [
              //   // Promotion drop down button
              //   Container(
              //     margin: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
              //     padding: const EdgeInsets.symmetric(horizontal: 12),
              //     decoration: BoxDecoration(
              //       color: const Color(0xFF0F172A),
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     child: DropdownButtonHideUnderline(
              //       child: DropdownButton<String>(
              //         value: candidate.stage,
              //         dropdownColor: const Color(0xFF0F172A),
              //         icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 18),
              //      
              //   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              //         items: const [
              //           DropdownMenuItem(value: "Applied", child: Text("Applied")),
              //           DropdownMenuItem(value: "Screening", child: Text("Screening")),
              //           DropdownMenuItem(value: "HR Round", child: Text("HR Round")),
              //           DropdownMenuItem(value: "Technical Round", child: Text("Technical Round")),
              //           DropdownMenuItem(value: "Presentation", child: Text("Presentation")),
              //         ],
              //         onChanged: (newStage) {
              //           if (newStage != null) {
              //             candCubit.moveCandidate(candidate.emailFrom, newStage);
              //             ScaffoldMessenger.of(context).showSnackBar(
              //               SnackBar(
              //                 content: Text("Moved to stage: $newStage"),
              //                 backgroundColor: AppColors.primary,
              //               ),
            ),
            body: Column(
              children: [
                // 🌟 HEADER CARD (PREMIUM METADATA VIEW)
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 42,
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            child: ClipOval(
                              child: candidate.image != null && candidate.image!.isNotEmpty
                                  ? Image.memory(
                                      base64Decode(candidate.image!),
                                      width: 84,
                                      height: 84,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.network(
                                          "https://i.pravatar.cc/150?u=${candidate.emailFrom}",
                                          width: 84,
                                          height: 84,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.network(
                                      "https://i.pravatar.cc/150?u=${candidate.emailFrom}",
                                      width: 84,
                                      height: 84,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  candidate.fullName,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.school_outlined, size: 15, color: Color(0xFF64748B)),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        candidate.typeId,
                                        style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Priority evaluation stars
                                Row(
                                  children: List.generate(3, (starIdx) {
                                    return Icon(
                                      Icons.star_rounded,
                                      size: 20,
                                      color: starIdx < (int.tryParse(candidate.priority) ?? 0)
                                          ? AppColors.warning
                                          : const Color(0xFFCBD5E1),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // TAB NAVIGATION
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 3,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: const Color(0xFF64748B),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    tabs: const [
                      Tab(text: "Contact & Bio"),
                      // Combined Skills and Meta into one tab (slide)
                      Tab(text: "Skills & Meta"),
                    ],
                  ),
                ),

                // DETAILS CONTENT
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // TAB 1: Contact details
                      _buildContactTab(candidate),
                      // TAB 2: Skills and Meta Information combined in a single slide (view-only)
                      _buildSkillsAndMetaTab(context, candidate, candCubit),
                    ],
                  ),
                ),

                // ⚡ BOTTOM FLOATING ACTIONS FOR ODOO INTERACTIVE METHODS
                _buildFloatingActionsBar(context, candidate, candCubit),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactTab(HrCandidate candidate) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildInfoCard("Primary Contact", [
          _buildDetailRow(Icons.email_outlined, "Email Address", candidate.emailFrom, isCopyable: true),
          _buildDetailRow(Icons.phone_outlined, "Mobile Phone", candidate.partnerPhone),
          _buildDetailRow(Icons.phone_iphone_outlined, "Alternate Phone", candidate.alternatePhone ?? "Not provided"),
          _buildDetailRow(Icons.link_rounded, "LinkedIn Profile", candidate.linkedinProfile ?? "Not linked"),
        ]),
        const SizedBox(height: 16),
        _buildInfoCard("Recruitment Information", [
          _buildDetailRow(Icons.person_pin_outlined, "Contact Partner Name", candidate.partnerId),
          _buildDetailRow(Icons.badge_outlined, "Candidate Manager", candidate.userId),
          _buildDetailRow(Icons.corporate_fare_outlined, "Odoo Company", candidate.companyId),
        ]),
      ],
    );
  }

  /// 🧬 Combined Skills & Meta Information Tab (Single Slide View)
  /// This view displays both Candidate Status details (Meta info) and the Skills List.
  /// Note: Skills are displayed as VIEW-ONLY (no add or delete buttons).
  Widget _buildSkillsAndMetaTab(BuildContext context, HrCandidate candidate, CandidateCubit cubit) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // 1. CANDIDATE STATUS INFO (Formerly Meta & Actions Tab)
        _buildInfoCard("Candidate Status Info", [
          _buildDetailRow(Icons.calendar_month_outlined, "Availability Date", DateFormat('dd MMMM yyyy').format(candidate.availability)),
          _buildDetailRow(Icons.bookmark_outline, "Recruitment Stage", candidate.stage),
          // _buildDetailRow(Icons.app_registration_outlined, "Job Application Link", candidate.linkedApplicationId ?? "None (Draft)"),
        ]),
        if (candidate.categIds.isNotEmpty) ...[
          const SizedBox(height: 16),
          _buildTagsCard(candidate.categIds),
        ],
        const SizedBox(height: 24),

        // 2. ODOO SKILLS LIST SECTION (Formerly Skills Mapping Tab, now VIEW-ONLY)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Odoo Skills List",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (candidate.skills.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: Text("No skills mapped for this candidate yet.")),
            ),
          )
        else
          ...candidate.skills.map((skill) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.psychology, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              skill.skillId,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFCBD5E1)),
                              ),
                              child: Text(
                                skill.skillLevel,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF475569)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Type: ${skill.skillTypeId}",
                          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  ),
                  // Note: The delete button/IconButton has been removed to enforce VIEW-ONLY mode.
                ],
              ),
            );
          }).toList(),
      ],
    );
  }

  Widget _buildFloatingActionsBar(BuildContext context, HrCandidate candidate, CandidateCubit cubit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Builder(
          builder: (iconContext) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: iconContext.read<ProfileCubit>(),
                      child: ResumePage(
                        candidateId: candidate.odooId,
                        email: candidate.emailFrom,
                      ),
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width:double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Icon(Icons.article_outlined, color: Color(0xFF0F172A), size: 20),
              ),
            );
          }
        ),
      ),
    );
  }

  // Info card styling helper
  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF475569)),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {bool isCopyable = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF94A3B8), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF0F172A), fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsCard(List<String> tags) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x050F172A),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.local_offer_outlined, size: 18, color: Color(0xFF64748B)),
              SizedBox(width: 8),
              Text(
                "Candidate Tags",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF475569),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags.map((tag) {
              final isIt = tag.toLowerCase() == 'it';
              final isReserve = tag.toLowerCase() == 'reserve';
              
              final bgColor = isIt 
                  ? const Color(0xFFEEF2FF) 
                  : (isReserve ? const Color(0xFFFFF7ED) : const Color(0xFFF1F5F9));
              final textColor = isIt 
                  ? const Color(0xFF4F46E5) 
                  : (isReserve ? const Color(0xFFEA580C) : const Color(0xFF475569));
              final borderColor = isIt 
                  ? const Color(0xFFC7D2FE) 
                  : (isReserve ? const Color(0xFFFED7AA) : const Color(0xFFE2E8F0));

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

}
