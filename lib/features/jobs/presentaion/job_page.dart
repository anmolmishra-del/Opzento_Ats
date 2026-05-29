import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/jobs/model/model_class.dart';
import 'package:opsento_ats/features/jobs/presentaion/create_job.dart';
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
  final _service = HrJobService();
  bool _loadingJobs = false;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    setState(() => _loadingJobs = true);

    try {
      final jobs = await _service.fetchJobs();
      if (mounted) {
        context.read<JobCubit>().setJobs(jobs);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sync jobs from Odoo: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loadingJobs = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<JobCubit, JobState>(
            builder: (context, state) {
              final cubit = context.read<JobCubit>();
              // final bool isRecruiter = true;
              // FILTER LOGIC
              List<JobData> filteredJobs = state.jobs.where((job) {
                final matchTab = state.selectedTab == "All"
                    ? true
                    : job.status == state.selectedTab;
                final matchSearch = job.title.toLowerCase().contains(
                  state.searchQuery.toLowerCase(),
                );
                return matchTab && matchSearch;
              }).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TITLE
                  // ROLE CHECK
                  Row(
                    children: [
                      const Text(
                        "Jobs",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),

                      // ONLY RECRUITER CAN SEE CREATE BUTTON
                      if (widget.isRecruiter)
                        IconButton(
                          onPressed: () {
                            _showCreateJobModal(context);
                          },
                          icon: const Icon(Icons.add_circle, size: 32),
                          color: Colors.deepPurple,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (widget.isRecruiter)
                    if (widget.isRecruiter) const SizedBox(height: 12),

                  // TABS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      _tab("All", state.selectedTab, cubit),

                      _tab("Open", state.selectedTab, cubit),

                      // ONLY RECRUITER
                      if (widget.isRecruiter) ...[
                        _tab("Draft", state.selectedTab, cubit),

                        _tab("Closed", state.selectedTab, cubit),
                      ],
                    ],
                  ),

                  const SizedBox(height: 20),
                  if (_loadingJobs)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: LinearProgressIndicator(),
                    ),

                  // JOB LIST
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _loadJobs,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: filteredJobs.length,
                        itemBuilder: (context, index) {
                        final job = filteredJobs[index];

                        return InkWell(
                          borderRadius: BorderRadius.circular(14),
                        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) =>RecruitmentCreatePage()
    ),
  );
},
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.grey.shade300),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.deepPurple.shade100,
                                  child: const Icon(Icons.work),
                                ),
                                const SizedBox(width: 12),

                                // DETAILS
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(job.department),
                                    ],
                                  ),
                                ),

                                // CATEGORY
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        job.category.isEmpty ? 'Uncategorized' : job.category,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              )],
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
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.deepPurple : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          if (isActive)
            Container(height: 3, width: 30, color: Colors.deepPurple),
        ],
      ),
    );
  }



  void _showCreateJobModal(BuildContext context, {JobData? job}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => _CreateJobForm(
          scrollController: scrollController,
          cubit: context.read<JobCubit>(),
          job: job,
          onSuccess: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class _CreateJobForm extends StatefulWidget {
  final ScrollController scrollController;
  final JobCubit cubit;
  final VoidCallback onSuccess;
  final JobData? job;

  const _CreateJobForm({
    required this.scrollController,
    required this.cubit,
    required this.onSuccess,
    this.job,
  });

  @override
  State<_CreateJobForm> createState() => _CreateJobFormState();
}

class _CreateJobFormState extends State<_CreateJobForm> {
  final _titleCtrl = TextEditingController();

  int? _selectedDeptId;
  int? _selectedCategoryId;

  List<Map<String, dynamic>> _departments = [];
  List<Map<String, dynamic>> _categories = [];
  final _service = HrJobService();

  bool _loading = false;
  bool _loadingDropdowns = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl.text = widget.job?.title ?? '';
    _fetchDropdowns();
  }

  Future<void> _fetchDropdowns() async {
    setState(() => _loadingDropdowns = true);
    print('🔄 _fetchDropdowns: Starting fetch...');

    try {
      print('📦 Fetching departments...');
      final departments = await _service.fetchDepartments();
      print('✅ Departments fetched: ${departments.length} items');

      print('📦 Fetching categories...');
      final categories = await _service.fetchCategories();
      print('✅ Categories fetched: ${categories.length} items');

      if (mounted) {
        setState(() {
          _departments = departments;
          _categories = categories;
        });
        print('✅ UI state updated with dropdowns');
        // If editing an existing job, attempt to preselect department/category by name
        if (widget.job != null) {
          final job = widget.job!;
          try {
            final dept = _departments.firstWhere((d) => (d['name'] ?? '').toString() == job.department);
            _selectedDeptId = dept['id'] as int?;
          } catch (_) {}

          try {
            final cat = _categories.firstWhere((c) => (c['name'] ?? '').toString() == job.category);
            _selectedCategoryId = cat['id'] as int?;
          } catch (_) {}
        }
      }
    } catch (e) {
      print('❌ _fetchDropdowns error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch dropdowns: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loadingDropdowns = false);
      print('✅ _fetchDropdowns: Complete');
    }
  }

  Future<void> _createHrJob() async {
    final title = _titleCtrl.text.trim();
    print('🚀 _createHrJob: Starting with title="$title"');

    if (title.isEmpty) {
      print('⚠️ _createHrJob: Title is empty!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter job position')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      print('📤 Calling _service.createHrJob()...');
      final newJob = await _service.createHrJob(
        title: title,
        departmentId: _selectedDeptId,
        categoryId: _selectedCategoryId,
      );
      print('📥 Service response: $newJob');

      if (newJob == null) {
        print('❌ newJob is NULL - creation failed');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to create job. Check the form and try again.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
        return;
      }

      print('✅ newJob created: title=${newJob.title}');

      if (mounted) {
        print('📝 Adding job to cubit...');
        widget.cubit.addJob(newJob);
        print('✅ Job added to cubit');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job created successfully')),
        );
        print('✅ Calling onSuccess callback...');
        widget.onSuccess();
      }
    } catch (e) {
      print('❌ _createHrJob exception: $e');

      if (mounted) {
        String errorMsg = 'Failed to create job';
        final err = e.toString();

        if (err.contains('must be unique')) {
          errorMsg = 'Job position name must be unique in this department.\nTry a different name or department.';
          print('⚠️ Unique constraint violation');
        } else if (err.contains('Permission denied') || err.contains('AccessError')) {
          errorMsg = "Permission denied: you need 'Recruitment/Officer' access.";
          print('🔐 Permission error detected');
        } else if (err.contains('Exception:')) {
          final match = RegExp(r"Exception: (.+?)(?:\)|$)").firstMatch(err);
          if (match != null) {
            errorMsg = match.group(1) ?? 'Failed to create job';
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
      print('✅ _createHrJob: Complete');
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loadingDropdowns
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            controller: widget.scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Create Job Position',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // JOB TITLE
              TextField(
                controller: _titleCtrl,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  labelText: 'Job Position *',
                  hintText: 'Enter job title',
                  prefixIcon: const Icon(Icons.work_outline, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // DEPARTMENT DROPDOWN
              DropdownButtonFormField<int>(
                value: _selectedDeptId,
                hint: const Text('Select Department'),
                decoration: InputDecoration(
                  labelText: 'Department',
                  prefixIcon: const Icon(Icons.apartment, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                items: _departments.map((dept) {
                  return DropdownMenuItem<int>(
                    value: dept['id'] as int,
                    child: Text(dept['name']?.toString() ?? 'Unknown'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedDeptId = value);
                },
              ),
              const SizedBox(height: 16),

              // CATEGORY DROPDOWN
              DropdownButtonFormField<int>(
                value: _selectedCategoryId,
                hint: const Text('Select Category'),
                decoration: InputDecoration(
                  labelText: 'Job Category',
                  prefixIcon: const Icon(Icons.category, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                items: _categories.map((cat) {
                  return DropdownMenuItem<int>(
                    value: cat['id'] as int,
                    child: Text(cat['name']?.toString() ?? 'Unknown'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedCategoryId = value);
                },
              ),
              const SizedBox(height: 32),

              // CREATE BUTTON
              ElevatedButton(
                onPressed: _loading ? null : _createHrJob,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  disabledBackgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Create Job Position',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(height: 24),
            ],
          );
  }
}
