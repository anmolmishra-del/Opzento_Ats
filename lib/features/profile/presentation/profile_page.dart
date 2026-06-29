import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/edit_profile/presention/edit_profile_page.dart';
import 'package:opsento_ats/features/profile/cubit/profile_cubit.dart';
import 'package:opsento_ats/features/profile/state/profile_state.dart';
import 'package:opsento_ats/routes/app_routes.dart';
import 'package:opsento_ats/features/auth/cubit/login_cubit.dart';

class RecruiterProfilePage extends StatelessWidget {
  const RecruiterProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocBuilder<RecruiterProfileCubit, RecruiterProfileState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                // 1. Gradient Header Background
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo, Colors.indigo],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -50,
                        right: -50,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        left: -30,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      // Back Button
                      Positioned(
                        top: 48,
                        left: 16,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                      // Title
                      const Positioned(
                        top: 60,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'My Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      // Edit Button
                    
                     
                    ],
                  ),
                ),

                // 2. Profile Content overlapping the header
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: state.isLoading
                      ? const Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Column(
                          children: [
                            _buildProfileCard(context, state),
                            const SizedBox(height: 20),
                            _buildStatsSection(state),
                            const SizedBox(height: 20),
                            _buildInfoSection(state),
                            const SizedBox(height: 30),
                            _buildLogoutButton(context),
                            const SizedBox(height: 40),
                          ],
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, RecruiterProfileState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 10,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: state.image.isNotEmpty
                  ? MemoryImage(base64Decode(state.image))
                  : null,
              child: state.image.isEmpty
                  ? const Icon(Icons.person, size: 50, color: Colors.grey)
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            state.name.isEmpty ? 'Unknown' : state.name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            state.role.isEmpty ? 'N/A' : state.role,
            style: const TextStyle(
              color: Colors.indigo,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          _buildContactTile(Icons.email_outlined, state.email, Colors.orange),
          const SizedBox(height: 12),
          _buildContactTile(Icons.phone_outlined, state.phone, Colors.blue),
          const SizedBox(height: 12),
          _buildContactTile(Icons.location_on_outlined, state.location, Colors.green),
        ],
      ),
    );
  }

  Widget _buildContactTile(IconData icon, String text, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text.isEmpty ? 'Not specified' : text,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(RecruiterProfileState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  Icons.work_outline,
                  state.jobsPosted.toString(),
                  "Jobs Posted",
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  Icons.people_outline,
                  state.totalApplicants.toString(),
                  "Applicants",
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  Icons.person_add_alt_1_outlined,
                  state.hired.toString(),
                  "Hired",
                  Colors.indigo,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  Icons.remove_red_eye_outlined,
                  state.profileViews,
                  "Views",
                  Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(RecruiterProfileState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Information",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 24),
          _infoRow("Member Since", state.memberSince),
          const Divider(height: 24),
          _infoRow("Company", state.company),
          const Divider(height: 24),
          _infoRow("Designation", state.designation),
          const Divider(height: 24),
          _infoRow("Website", state.website),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value.isEmpty ? 'N/A' : value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () async {
            final cubit = context.read<LoginCubit>();
            await cubit.logout();
            
            if (context.mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              );
            }
          },
          icon: const Icon(Icons.logout, size: 22),
          label: const Text(
            "Logout",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade400,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
