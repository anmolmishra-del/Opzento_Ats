import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/state/candidate_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  /// 📄 LOAD RESUME
  Future<void> loadResume() async {
    try {
      emit(state.copyWith(loading: true));

      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
        loading: false,
        pdfUrl:
            "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
      ));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  /// 📥 DOWNLOAD RESUME (FIXED)
  Future<void> downloadResume(BuildContext context, String url) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Downloading Resume...")),
      );

      // 1️⃣ Permission FIRST
      await Permission.manageExternalStorage.request();

      Directory? dir;

      if (Platform.isAndroid) {
        // safer approach
        dir = await getExternalStorageDirectory();
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      final filePath = "${dir!.path}/resume.pdf";

      // 2️⃣ Download file
      await Dio().download(url, filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Saved at: $filePath")),
      );
    } catch (e) {
      print("Download error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Download Failed")),
      );
    }
  }

  /// ⭐ SHORTLIST
  void shortlist(BuildContext context) {
    emit(state.copyWith(
      isShortlisted: true,
      isRejected: false,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Candidate Shortlisted")),
    );
  }

  /// ❌ REJECT
  void reject(BuildContext context) {
    emit(state.copyWith(
      isRejected: true,
      isShortlisted: false,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Candidate Rejected")),
    );
  }

  /// ℹ️ MORE
  void more(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("More Details"),
          content: const Text(
            "Senior Flutter Developer with strong experience in Firebase, APIs and clean architecture.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        );
      },
    );
  }
}