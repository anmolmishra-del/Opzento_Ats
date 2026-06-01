import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:opsento_ats/core/services/odoo_service.dart';
import 'package:opsento_ats/core/constants/api_config.dart';
import '../state/candidate_state.dart';
import '../state/hr_candidate_model.dart';

class CandidateCubit extends Cubit<CandidateState> {
  late OdooService _svc;

  CandidateCubit() : super(CandidateState.initial()) {
    print("[CandidateCubit] Initialized CandidateCubit. Triggering data sync...");
    _svc = OdooService(ApiConfig.baseUrl);
    loadBackendDropdowns();
    loadCandidates();
  }

  /// 🔄 UPDATE SESSION AND REFRESH DATA (Call this after login!)
  Future<void> setSessionAndRefresh(OdooSession session) async {
    print("[CandidateCubit] setSessionAndRefresh() called with new session. User ID: ${session.userId}");
    
    // Close old service
    _svc.close();
    
    // Create new service with the new session
    _svc = OdooService(ApiConfig.baseUrl, session: session);
    
    // Clear old state and reload with new session (explicitly reset selectedCandidate)
    emit(CandidateState.initial().copyWith(
      selectedCandidate: null,
      isLoading: true,
    ));
    
    // Reload all data with the new session
    await loadBackendDropdowns();
    await loadCandidates();
    
    print("[CandidateCubit] setSessionAndRefresh() completed. Data reloaded.");
  }

  /// 🌐 FETCH CANDIDATES DYNAMICALLY FROM ODOO BACKEND
  Future<void> loadCandidates() async {
    print("[CandidateCubit] loadCandidates() started. Querying 'hr.applicant' from Odoo...");
    emit(state.copyWith(isLoading: true));
    try {
      // 1. Get valid fields from Odoo dynamically to prevent server ValueError
      Map<String, dynamic>? fieldsInfo;
      try {
        final rawFields = await _svc.executeModelMethod(
          'hr.candidate',
          'fields_get',
          [],
          kwargs: {'attributes': ['type']},
        );
        if (rawFields is Map) {
          fieldsInfo = Map<String, dynamic>.from(rawFields);
        }
      } catch (fe) {
        print("[CandidateCubit] fields_get failed, falling back to defaults. Error: $fe");
      }

      final List<String> requestedFields = [
        'id',
        'name',
        'partner_name',
        'email_from',
        'partner_phone',
        'type_id',
        'user_id',
        'priority',
        'availability',
        'company_id',
        'stage_id',
      ];

      // Only select fields that actually exist on the Odoo server
      final List<String> activeFields = fieldsInfo != null
          ? requestedFields.where((f) => fieldsInfo!.containsKey(f)).toList()
          : requestedFields;

      print("[CandidateCubit] loadCandidates() Odoo active fields: $activeFields");

      final candidatesRes = await _svc.executeModelMethod(
        'hr.candidate',
        'search_read',
        [[]],
        kwargs: {
          'fields': activeFields,
        },
      );

      print("[CandidateCubit] loadCandidates() Odoo raw response type: ${candidatesRes.runtimeType}");
      if (candidatesRes is List) {
        print("[CandidateCubit] loadCandidates() fetched ${candidatesRes.length} records successfully.");
        final parsed = candidatesRes.map((e) {
          final nameParts = (e['partner_name']?.toString() ?? e['name']?.toString() ?? 'Unknown').split(' ');
          final fName = nameParts.first;
          final lName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : 'Record';

          final degreeVal = e['type_id'];
          final degreeName = degreeVal is List && degreeVal.length > 1 ? degreeVal[1].toString() : '';

          final userVal = e['user_id'];
          final userName = userVal is List && userVal.length > 1 ? userVal[1].toString() : '';

          final compVal = e['company_id'];
          final compName = compVal is List && compVal.length > 1 ? compVal[1].toString() : '';

          final stageVal = e['stage_id'];
          final stageName = stageVal is List && stageVal.length > 1 ? stageVal[1].toString() : 'Applied';

          DateTime avail = DateTime.now();
          if (e['availability'] != null && e['availability'].toString().isNotEmpty) {
            try {
              avail = DateTime.parse(e['availability'].toString());
            } catch (_) {}
          }

          print("[CandidateCubit]   -> Loaded Candidate: $fName $lName, Email: ${e['email_from']}, Stage: $stageName");

          // Fix email parsing - handle boolean false values from Odoo
          final emailValue = e['email_from'];
          final emailFromValue = (emailValue is String && emailValue.isNotEmpty)
              ? emailValue
              : (emailValue == false || emailValue == 'false')
                  ? 'no-email@odoo.com'
                  : emailValue?.toString() ?? 'no-email@odoo.com';

          return HrCandidate(
            odooId: e['id'] is int ? e['id'] as int : int.tryParse(e['id']?.toString() ?? ''),
            firstName: fName,
            lastName: lName,
            partnerId: e['partner_name']?.toString() ?? e['name']?.toString() ?? 'Contact',
            emailFrom: emailFromValue,
            partnerPhone: e['partner_phone']?.toString() ?? 'Not provided',
            typeId: degreeName,
            userId: userName,
            priority: e['priority']?.toString() ?? '0',
            availability: avail,
            categIds: const [],
            companyId: compName,
            skills: const [],
            stage: stageName.contains('Screening') ? 'Screening' : (stageName.contains('HR') ? 'HR Round' : (stageName.contains('Tech') ? 'Technical Round' : 'Applied')),
          ).computeSkillIds().computeMatchingSkillIds(state.activeRequiredSkills);
        }).toList();

        emit(state.copyWith(candidates: parsed, isLoading: false));
      } else {
        print("[CandidateCubit] loadCandidates() Odoo returned non-list value: $candidatesRes");
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      print("[CandidateCubit] loadCandidates() Error: $e");
      emit(state.copyWith(isLoading: false));
    }
  }

  /// 🌐 FETCH ALL DROPDOWNS DYNAMICALLY FROM ODOO BACKEND
  Future<void> loadBackendDropdowns() async {
    print("[CandidateCubit] loadBackendDropdowns() started. Loading degree, user, company, and skill types from Odoo...");
    emit(state.copyWith(isLoading: true));
    try {
      final degreesRes = await _svc.executeModelMethod(
        'hr.recruitment.degree',
        'search_read',
        [[]],
        kwargs: {'fields': ['id', 'name']},
      );

      final usersRes = await _svc.executeModelMethod(
        'res.users',
        'search_read',
        [[]],
        kwargs: {'fields': ['id', 'name']},
      );

      final companiesRes = await _svc.executeModelMethod(
        'res.company',
        'search_read',
        [[]],
        kwargs: {'fields': ['id', 'name']},
      );

      final skillTypesRes = await _svc.executeModelMethod(
        'hr.skill.type',
        'search_read',
        [[]],
        kwargs: {'fields': ['id', 'name']},
      );

      final skillLevelsRes = await _svc.executeModelMethod(
        'hr.skill.level',
        'search_read',
        [[]],
        kwargs: {'fields': ['id', 'name']},
      );

      final skillsRes = await _svc.executeModelMethod(
        'hr.skill',
        'search_read',
        [[]],
        kwargs: {'fields': ['id', 'name', 'skill_type_id']},
      );

      print("[CandidateCubit] loadBackendDropdowns() Dropdowns fetched successfully:");
      print("   -> Degrees: ${degreesRes is List ? (degreesRes as List).length : 0} items");
      print("   -> Users/Managers: ${usersRes is List ? (usersRes as List).length : 0} items");
      print("   -> Companies: ${companiesRes is List ? (companiesRes as List).length : 0} items");
      print("   -> Skill Types: ${skillTypesRes is List ? (skillTypesRes as List).length : 0} items");
      print("   -> Skills Dictionary: ${skillsRes is List ? (skillsRes as List).length : 0} items");

      emit(state.copyWith(
        degrees: degreesRes is List && degreesRes.isNotEmpty 
            ? List<Map<String, dynamic>>.from(degreesRes.map((e) => {'id': e['id'], 'name': e['name'] ?? 'Unknown'}))
            : state.degrees,
        managers: usersRes is List && usersRes.isNotEmpty 
            ? List<Map<String, dynamic>>.from(usersRes.map((e) => {'id': e['id'], 'name': e['name'] ?? 'Unknown'}))
            : state.managers,
        companies: companiesRes is List && companiesRes.isNotEmpty 
            ? List<Map<String, dynamic>>.from(companiesRes.map((e) => {'id': e['id'], 'name': e['name'] ?? 'Unknown'}))
            : state.companies,
        skillTypes: skillTypesRes is List && skillTypesRes.isNotEmpty 
            ? List<Map<String, dynamic>>.from(skillTypesRes.map((e) => {'id': e['id'], 'name': e['name'] ?? 'Unknown'}))
            : state.skillTypes,
        skillLevels: skillLevelsRes is List && skillLevelsRes.isNotEmpty 
            ? List<Map<String, dynamic>>.from(skillLevelsRes.map((e) => {'id': e['id'], 'name': e['name'] ?? 'Unknown'}))
            : state.skillLevels,
        skills: skillsRes is List && skillsRes.isNotEmpty
            ? List<Map<String, dynamic>>.from(skillsRes.map((e) {
                final typeVal = e['skill_type_id'];
                final typeName = typeVal is List && typeVal.length > 1 ? typeVal[1]?.toString() ?? '' : '';
                return {
                  'id': e['id'],
                  'name': e['name'] ?? 'Unknown',
                  'skill_type_name': typeName,
                };
              }))
            : state.skills,
        isLoading: false,
      ));
    } catch (e) {
      print("[CandidateCubit] loadBackendDropdowns() Error: $e");
      emit(state.copyWith(isLoading: false));
    }
  }

  void changeTab(String tab) {
    emit(state.copyWith(selectedTab: tab));
  }

  void search(String value) {
    emit(state.copyWith(searchQuery: value));
  }

  void selectCandidate(HrCandidate candidate) {
    emit(state.copyWith(selectedCandidate: candidate));
  }

  /// ➕ ADD CANDIDATE (LOCAL PREVIEW & ASYNC CREATE TO ODOO)
  Future<void> addCandidate(HrCandidate candidate) async {
    print("[CandidateCubit] addCandidate() triggered for Candidate: ${candidate.fullName}");
    
    // 1. Add locally first for instant UI response
    final computed = candidate
        .computeSkillIds()
        .computeMatchingSkillIds(state.activeRequiredSkills);
        
    final list = List<HrCandidate>.from(state.candidates)..add(computed);
    emit(state.copyWith(candidates: list));
    print("[CandidateCubit] addCandidate() local state updated.");

    // 2. Call Odoo create method asynchronously
    try {
      // Get valid fields from Odoo dynamically to prevent server ValueError
      Map<String, dynamic>? fieldsInfo;
      try {
        final rawFields = await _svc.executeModelMethod(
          'hr.applicant',
          'fields_get',
          [],
          kwargs: {'attributes': ['type']},
        );
        if (rawFields is Map) {
          fieldsInfo = Map<String, dynamic>.from(rawFields);
        }
      } catch (fe) {
        print("[CandidateCubit] fields_get failed in create. Error: $fe");
      }

      // Find degree ID
      final degreeMap = state.degrees.firstWhere((e) => e['name'] == candidate.typeId, orElse: () => <String, dynamic>{});
      final degreeId = degreeMap['id'];

      // Find user ID
      final userMap = state.managers.firstWhere((e) => e['name'] == candidate.userId, orElse: () => <String, dynamic>{});
      final userId = userMap['id'];

      // Find company ID
      final companyMap = state.companies.firstWhere((e) => e['name'] == candidate.companyId, orElse: () => <String, dynamic>{});
      final companyId = companyMap['id'];

      final Map<String, dynamic> rawVals = {
        'name': "${candidate.firstName} ${candidate.lastName} - Application",
        'partner_name': candidate.fullName,
        'email_from': candidate.emailFrom,
        'partner_phone': candidate.partnerPhone,
        'priority': candidate.priority,
        'availability': candidate.availability.toIso8601String().split('T').first,
        'type_id': degreeId,
        'user_id': userId,
        'company_id': companyId,
      };

      // Only include fields that actually exist on the Odoo server!
      final Map<String, dynamic> createVals = {};
      rawVals.forEach((key, val) {
        if (val != null) {
          if (fieldsInfo == null || fieldsInfo.containsKey(key)) {
            createVals[key] = val;
          } else {
            print("[CandidateCubit] Filtering out unsupported Odoo field: '$key'");
          }
        }
      });

      print("[CandidateCubit] Resolved Odoo relations:");
      print("   -> degreeId: $degreeId ('${candidate.typeId}')");
      print("   -> userId: $userId ('${candidate.userId}')");
      print("   -> companyId: $companyId ('${candidate.companyId}')");
      print("[CandidateCubit] Final Odoo creation payload after dynamic filtering: $createVals");

      final createRes = await _svc.executeModelMethod(
        'hr.applicant',
        'create',
        [createVals],
      );
      print("[CandidateCubit] Odoo creation response: $createRes");
      
      // Refresh list to pull fully-mapped record and IDs from Odoo
      await loadCandidates();
    } catch (e) {
      print("[CandidateCubit] Odoo Create Exception caught: $e");
    }
  }

  /// 🔄 UPDATE CANDIDATE STAGE
  void moveCandidate(String email, String newStage) {
    final updated = state.candidates.map((c) {
      if (c.emailFrom == email) {
        return c.copyWith(stage: newStage);
      }
      return c;
    }).toList();

    emit(state.copyWith(candidates: updated));
    
    // Also update selected candidate if it matches
    if (state.selectedCandidate?.emailFrom == email) {
      final updatedSel = state.selectedCandidate!.copyWith(stage: newStage);
      emit(state.copyWith(selectedCandidate: updatedSel));
    }
  }

  /// 🛠️ Odoo Action: Matching Candidate Skills
  /// Compares candidate skills with job-required skills and calculates the matching percentage score.
  void executeMatchingSkills(String email) {
    final updated = state.candidates.map((c) {
      if (c.emailFrom == email) {
        return c.computeSkillIds().computeMatchingSkillIds(state.activeRequiredSkills);
      }
      return c;
    }).toList();

    emit(state.copyWith(candidates: updated));

    // Update selected candidate if matches
    final found = updated.firstWhere((c) => c.emailFrom == email);
    emit(state.copyWith(selectedCandidate: found));
  }

  /// 🛠️ Odoo Action: Candidate Skill Mapping
  /// Automatically updates candidate skills list from lines.
  void updateCandidateSkills(String email, List<HrCandidateSkill> newSkills) {
    final updated = state.candidates.map((c) {
      if (c.emailFrom == email) {
        final withSkills = c.copyWith(skills: newSkills);
        return withSkills.computeSkillIds().computeMatchingSkillIds(state.activeRequiredSkills);
      }
      return c;
    }).toList();

    emit(state.copyWith(candidates: updated));

    // Update selected candidate if matches
    final found = updated.firstWhere((c) => c.emailFrom == email);
    emit(state.copyWith(selectedCandidate: found));
  }

  /// 🛠️ Odoo Action: Create Job Application
  /// Generates applicant records linked to the selected job.
  void executeCreateJobApplication(String email) {
    final updated = state.candidates.map((c) {
      if (c.emailFrom == email) {
        return c.actionCreateApplication("JOB-POS-FLUTTER");
      }
      return c;
    }).toList();

    emit(state.copyWith(candidates: updated));

    // Update selected candidate
    final found = updated.firstWhere((c) => c.emailFrom == email);
    emit(state.copyWith(selectedCandidate: found));
  }
}
