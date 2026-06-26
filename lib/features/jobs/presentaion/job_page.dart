import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/jobs/model/model_class.dart';
import 'package:opsento_ats/features/jobs/presentaion/create_job.dart';
import 'package:opsento_ats/features/jobs/presentaion/job_detils_page.dart';
import 'package:opsento_ats/features/jobs/repository/hr_job_service file.dart';
import '../cubit/job_cubit.dart';
import '../state/job_state.dart';

class JobPage extends StatefulWidget {
  final bool isRecruiter;
  const JobPage({super.key, required this.isRecruiter});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {

  @override
  void initState() {
    super.initState();
    context.read<JobCubit>().fetchJobs();
  }

  @override
  Color _getCategoryBgColor(String category) {
    final lower = category.toLowerCase().trim();
    if (lower == 'development') return const Color(0xFFEFF6FF); // Soft blue
    if (lower == 'testing') return const Color(0xFFF3E8FF); // Soft purple
    if (lower == 'integration') return const Color(0xFFECFDF5); // Soft green
    if (lower == 'screening' || lower == 'hr') return const Color(0xFFFFF7ED); // Soft orange
    return const Color(0xFFF1F5F9); // Soft grey
  }

  Color _getCategoryTextColor(String category) {
    final lower = category.toLowerCase().trim();
    if (lower == 'development') return const Color(0xFF1D4ED8);
    if (lower == 'testing') return const Color(0xFF7E22CE);
    if (lower == 'integration') return const Color(0xFF047857);
    if (lower == 'screening' || lower == 'hr') return const Color(0xFFC2410C);
    return const Color(0xFF475569);
  }

  String _cleanCategoryName(String category) {
    final trimmed = category.trim();
    if (trimmed.isEmpty || trimmed.toLowerCase() == 'false' || trimmed.toLowerCase() == 'null' || trimmed.toLowerCase() == 'n/a') {
      return 'Development'; // Default clean category
    }
    return trimmed;
  }

  Color _getPriorityBgColor(String priority) {
    final lower = priority.toLowerCase().trim();
    if (lower.contains('very high') || lower == '0' || lower == 'high') return const Color(0xFFFEF2F2); // Red 50
    if (lower.contains('medium') || lower == '1') return const Color(0xFFFFFBEB); // Amber 50
    return const Color(0xFFF8FAFC); // Slate 50
  }

  Color _getPriorityTextColor(String priority) {
    final lower = priority.toLowerCase().trim();
    if (lower.contains('very high') || lower == '0' || lower == 'high') return const Color(0xFFDC2626); // Red 600
    if (lower.contains('medium') || lower == '1') return const Color(0xFFD97706); // Amber 600
    return const Color(0xFF64748B); // Slate 600
  }

  Widget _buildSmallBadge({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Modern slate background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: BlocConsumer<JobCubit, JobState>(
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to sync jobs from Odoo: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<JobCubit>();
              
              // FILTER LOGIC
              List<JobData> filteredJobs = state.jobs.where((job) {
                final matchTab = state.selectedTab == "All"
                    ? true
                    : state.selectedTab == "Published"
                        ? job.isPublished == true
                        : state.selectedTab == "Unpublished"
                            ? job.isPublished == false
                            : true;
                final matchSearch = job.title.toLowerCase().contains(
                  state.searchQuery.toLowerCase(),
                );
                return matchTab && matchSearch;
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🌟 PREMIUM HEADER
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Jobs Positions",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Manage job postings",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // ONLY RECRUITER CAN SEE CREATE BUTTON
                      // if (widget.isRecruiter)
                      //   Container(
                      //     decoration: BoxDecoration(
                      //       color: const Color(0xFF4F46E5), // Indigo accent
                      //       shape: BoxShape.circle,
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: const Color(0xFF4F46E5).withOpacity(0.3),
                      //           blurRadius: 12,
                      //           offset: const Offset(0, 4),
                      //         )
                      //       ],
                      //     ),
                      //     child: IconButton(
                      //       onPressed: () {
                      //         _showCreateJobModal(context);
                      //       },
                      //       icon: const Icon(Icons.add, size: 24, color: Colors.white),
                      //     ),
                      //   ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 🔍 SEARCH BAR
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (v) => cubit.search(v),
                      decoration: InputDecoration(
                        hintText: "Search ...",
                        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF64748B), size: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 📊 TAB CONTROLS (PILL DESIGN)
                  Container(
                    height: 48,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(14),border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: _tab("All", state.selectedTab, cubit)),
                        Expanded(child: _tab("Published", state.selectedTab, cubit)),
                        Expanded(child: _tab("Unpublished", state.selectedTab, cubit)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: LinearProgressIndicator(
                        backgroundColor: Color(0xFFE2E8F0),
                        color: Color(0xFF4F46E5),
                      ),
                    ),

                  // 💼 JOB LIST
                  Expanded(
                    child: filteredJobs.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.work_off_outlined, size: 64, color: Colors.grey),
                                const SizedBox(height: 12),
                                const Text(
                                  "No job requisitions found",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF475569),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "Try tweaking your search or filters",
                                  style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () => context.read<JobCubit>().fetchJobs(),
                            color: const Color(0xFF4F46E5),
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: filteredJobs.length,
                              itemBuilder: (context, index) {
                                final job = filteredJobs[index];
                                final cleanCat = _cleanCategoryName(job.category);
                                final catBg = _getCategoryBgColor(cleanCat);
                                final catText = _getCategoryTextColor(cleanCat);

                                // Dynamic Accent Color based on Status
                                Color statusAccent = const Color(0xFF10B981); // Emerald Green for Open
                                if (job.status.toLowerCase() == 'draft') {
                                  statusAccent = const Color(0xFFF59E0B); // Amber
                                } else if (job.status.toLowerCase() == 'closed') {
                                  statusAccent = const Color(0xFFEF4444); // Red
                                }

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF0F172A).withOpacity(0.04),
                                        blurRadius: 14,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          // 🟢 Left Accent Status Line
                                          Container(
                                            width: 5,
                                            decoration:BoxDecoration(border: Border(
          left: BorderSide(
            color: Colors.primaries[job.hashCode % Colors.primaries.length],
            width: 4,
          ))),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => CreateJobdetailsPage(
                                                      job: job,
                                                      isRecruiter: widget.isRecruiter,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(16),
                                                child: Row(
                                                  children: [
                                                    // Icon avatar
                                                    Container(
                                                      padding: const EdgeInsets.all(12),
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xFFEEF2FF),
                                                        borderRadius: BorderRadius.circular(16),
                                                      ),
                                                      child: const Icon(
                                                        Icons.business_center_rounded,
                                                        color: Color(0xFF4F46E5),
                                                        size: 24,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16),
                                                    // Details
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            job.title,
                                                            style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w800,
                                                              color: Color(0xFF0F172A),
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          const SizedBox(height: 4),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.badge_outlined,
                                                                size: 13,
                                                                color: Color(0xFF64748B),
                                                              ),
                                                              const SizedBox(width: 4),
                                                              Expanded(
                                                                child: Text(
                                                                  "Job Position: ${job.department}",
                                                                  style: const TextStyle(
                                                                    fontSize: 13,
                                                                    color: Color(0xFF64748B),
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 8),
                                                          Wrap(
                                                            spacing: 6,
                                                            runSpacing: 4,
                                                            children: [
                                                              // Priority Badge
                                                              _buildSmallBadge(
                                                                icon: Icons.star_rounded,
                                                                label: job.priority.isEmpty ? 'Medium' : job.priority,
                                                                bgColor: _getPriorityBgColor(job.priority),
                                                                textColor: _getPriorityTextColor(job.priority),
                                                              ),
                                                              // Budget Badge
                                                              _buildSmallBadge(
                                                                icon: Icons.monetization_on_outlined,
                                                                label: job.salary.isEmpty ? 'N/A' : job.salary,
                                                                bgColor: const Color(0xFFEFF6FF), // Soft blue bg
                                                                textColor: const Color(0xFF1D4ED8), // Soft blue text
                                                              ),
                                                              // Published Badge
                                                              _buildSmallBadge(
                                                                icon: job.isPublished ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                                                                label: job.isPublished ? 'Published' : 'Draft',
                                                                bgColor: job.isPublished ? const Color(0xFFECFDF5) : const Color(0xFFF1F5F9),
                                                                textColor: job.isPublished ? const Color(0xFF047857) : const Color(0xFF475569),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),

                                                    // Category Capsule Badge
                                                    Container(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: catBg,
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                      child: Text(
                                                        cleanCat,
                                                        style: TextStyle(
                                                          color: catText,
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ),

                                            ),
                                          
                                          ),
                                        
                                        ],
                                        
                                      ),
                                      
                                    ),
                                  ),
                                );
                                
                              },
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _tab(String label, String selected, JobCubit cubit) {
    final isActive = label == selected;

    return GestureDetector(
      onTap: () => cubit.changeTab(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withOpacity(0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}


//   void _showCreateJobModal(BuildContext context, {JobData? job}) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => DraggableScrollableSheet(
//         expand: false,
//         initialChildSize: 0.9,
//         maxChildSize: 0.95,
//         minChildSize: 0.5,
//         builder: (context, scrollController) => _CreateJobForm(
//           scrollController: scrollController,
//           cubit: context.read<JobCubit>(),
//           job: job,
//           onSuccess: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//     );
//   }
// }

// class _CreateJobForm extends StatefulWidget {
//   final ScrollController scrollController;
//   final JobCubit cubit;
//   final VoidCallback onSuccess;
//   final JobData? job;

//   const _CreateJobForm({
//     required this.scrollController,
//     required this.cubit,
//     required this.onSuccess,
//     this.job,
//   });

//   @override
//   State<_CreateJobForm> createState() => _CreateJobFormState();
// }

// class _CreateJobFormState extends State<_CreateJobForm> {
//   final _titleCtrl = TextEditingController();

//   int? _selectedDeptId;
//   int? _selectedCategoryId;

//   List<Map<String, dynamic>> _departments = [];
//   List<Map<String, dynamic>> _categories = [];
//   final _service = HrJobService();

//   bool _loading = false;
//   bool _loadingDropdowns = false;

//   @override
//   void initState() {
//     super.initState();
//     _titleCtrl.text = widget.job?.title ?? '';
//     _fetchDropdowns();
//   }

//   Future<void> _fetchDropdowns() async {
//     setState(() => _loadingDropdowns = true);
//     print('🔄 _fetchDropdowns: Starting fetch...');

//     try {
//       print('📦 Fetching departments...');
//       final departments = await _service.fetchDepartments();
//       print('✅ Departments fetched: ${departments.length} items');

//       print('📦 Fetching categories...');
//       final categories = await _service.fetchCategories();
//       print('✅ Categories fetched: ${categories.length} items');

//       if (mounted) {
//         setState(() {
//           _departments = departments;
//           _categories = categories;
//         });
//         print('✅ UI state updated with dropdowns');
//         // If editing an existing job, attempt to preselect department/category by name
//         if (widget.job != null) {
//           final job = widget.job!;
//           try {
//             final dept = _departments.firstWhere((d) => (d['name'] ?? '').toString() == job.department);
//             _selectedDeptId = dept['id'] as int?;
//           } catch (_) {}

//           try {
//             final cat = _categories.firstWhere((c) => (c['name'] ?? '').toString() == job.category);
//             _selectedCategoryId = cat['id'] as int?;
//           } catch (_) {}
//         }
//       }
//     } catch (e) {
//       print('❌ _fetchDropdowns error: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to fetch dropdowns: $e')),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _loadingDropdowns = false);
//       print('✅ _fetchDropdowns: Complete');
//     }
//   }

//   Future<void> _createHrJob() async {
//     final title = _titleCtrl.text.trim();
//     print('🚀 _createHrJob: Starting with title="$title"');

//     if (title.isEmpty) {
//       print('⚠️ _createHrJob: Title is empty!');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter job position')),
//       );
//       return;
//     }

//     setState(() => _loading = true);

//     try {
//       print('📤 Calling _service.createHrJob()...');
//       final newJob = await _service.createHrJob(
//         title: title,
//         departmentId: _selectedDeptId,
//         categoryId: _selectedCategoryId,
//       );
//       print('📥 Service response: $newJob');

//       if (newJob == null) {
//         print('❌ newJob is NULL - creation failed');
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Failed to create job. Check the form and try again.'),
//               duration: Duration(seconds: 3),
//             ),
//           );
//         }
//         return;
//       }

//       print('✅ newJob created: title=${newJob.title}');

//       if (mounted) {
//         print('📝 Adding job to cubit...');
//         widget.cubit.addJob(newJob);
//         print('✅ Job added to cubit');

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Job created successfully')),
//         );
//         print('✅ Calling onSuccess callback...');
//         widget.onSuccess();
//       }
//     } catch (e) {
//       print('❌ _createHrJob exception: $e');

//       if (mounted) {
//         String errorMsg = 'Failed to create job';
//         final err = e.toString();

//         if (err.contains('must be unique')) {
//           errorMsg = 'Job position name must be unique in this department.\nTry a different name or department.';
//           print('⚠️ Unique constraint violation');
//         } else if (err.contains('Permission denied') || err.contains('AccessError')) {
//           errorMsg = "Permission denied: you need 'Recruitment/Officer' access.";
//           print('🔐 Permission error detected');
//         } else if (err.contains('Exception:')) {
//           final match = RegExp(r"Exception: (.+?)(?:\)|$)").firstMatch(err);
//           if (match != null) {
//             errorMsg = match.group(1) ?? 'Failed to create job';
//           }
//         }

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(errorMsg),
//             duration: const Duration(seconds: 4),
//           ),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _loading = false);
//       print('✅ _createHrJob: Complete');
//     }
//   }

//   @override
//   void dispose() {
//     _titleCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _loadingDropdowns
//         ? const Center(child: CircularProgressIndicator())
//         : ListView(
//             controller: widget.scrollController,
//             padding: const EdgeInsets.all(16),
//             children: [
//               // HEADER
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Create Job Position',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // JOB TITLE
//               TextField(
//                 controller: _titleCtrl,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//                 decoration: InputDecoration(
//                   labelText: 'Job Position *',
//                   hintText: 'Enter job title',
//                   prefixIcon: const Icon(Icons.work_outline, color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey.shade50,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // DEPARTMENT DROPDOWN
//               DropdownButtonFormField<int>(
//                 value: _selectedDeptId,
//                 hint: const Text('Select Department'),
//                 decoration: InputDecoration(
//                   labelText: 'Department',
//                   prefixIcon: const Icon(Icons.apartment, color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey.shade50,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                 ),
//                 items: _departments.map((dept) {
//                   return DropdownMenuItem<int>(
//                     value: dept['id'] as int,
//                     child: Text(dept['name']?.toString() ?? 'Unknown'),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() => _selectedDeptId = value);
//                 },
//               ),
//               const SizedBox(height: 16),

//               // CATEGORY DROPDOWN
//               DropdownButtonFormField<int>(
//                 value: _selectedCategoryId,
//                 hint: const Text('Select Category'),
//                 decoration: InputDecoration(
//                   labelText: 'Job Category',
//                   prefixIcon: const Icon(Icons.category, color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey.shade50,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide(color: Colors.grey.shade300),
//                   ),
//                 ),
//                 items: _categories.map((cat) {
//                   return DropdownMenuItem<int>(
//                     value: cat['id'] as int,
//                     child: Text(cat['name']?.toString() ?? 'Unknown'),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() => _selectedCategoryId = value);
//                 },
//               ),
//               const SizedBox(height: 32),

//               // CREATE BUTTON
//               ElevatedButton(
//                 onPressed: _loading ? null : _createHrJob,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.deepPurple,
//                   disabledBackgroundColor: Colors.grey,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: _loading
//                     ? const SizedBox(
//                         height: 20,
//                         width: 20,
//                         child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation(Colors.white),
//                           strokeWidth: 2,
//                         ),
//                       )
//                     : const Text(
//                         'Create Job Position',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 24),
//             ],
//           );
//   }
// }
