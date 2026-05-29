// import 'package:opsento_ats/core/constants/api_config.dart';
import 'package:opsento_ats/core/constants/api_config.dart';
import 'package:opsento_ats/core/services/odoo_service.dart';
import 'package:opsento_ats/features/jobs/model/model_class.dart';

class HrJobRecruitmentService {
  final OdooService _svc;

  HrJobRecruitmentService({OdooService? svc}) : _svc = svc ?? OdooService(ApiConfig.baseUrl);

  Future<List<Map<String, dynamic>>> _fetchModel(String model, {List<String>? fields, int limit = 200}) async {
    final res = await _svc.executeModelMethod(
      model,
      'search_read',
      [[]],
      kwargs: {
        'fields': fields ?? ['id', 'name'],
        'limit': limit,
      },
    );

    if (res is List && res.isNotEmpty) {
      return List<Map<String, dynamic>>.from(
        res.map((e) => {'id': e['id'], 'name': e['name'] ?? e['display_name'] ?? 'Unknown'}),
      );
    }

    return [];
  }

  

  Future<int?> createRecruitment(Map<String, dynamic> payload) async {
    final created = await _svc.executeModelMethod('hr.job.recruitment', 'create', [payload]);
    if (created is int) return created;
    if (created is Map && created['id'] != null) return created['id'];
    return null;
  }

  static List<dynamic> many2manyIds(List<int> ids) => [6, 0, ids];
}

class HrJobService {
  final OdooService _svc;

  HrJobService({OdooService? odooService})
      : _svc = odooService ?? OdooService(ApiConfig.baseUrl);

  Future<List<Map<String, dynamic>>> _fetchModel(
    String model, {
    List<String>? fields,
    int limit = 200,
  }) async {
    final res = await _svc.executeModelMethod(
      model,
      'search_read',
      [[]],
      kwargs: {
        'fields': fields ?? ['id', 'name'],
        'limit': limit,
      },
    );

    if (res is List && res.isNotEmpty) {
      return List<Map<String, dynamic>>.from(
        res.map(
          (e) => {
            'id': e['id'],
            'name': e['name'] ?? e['display_name'] ?? 'Unknown',
          },
        ),
      );
    }

    return [];
  }

  Future<List<Map<String, dynamic>>> fetchDepartments() async {
    final deptResult = await _svc.executeModelMethod(
      'hr.department',
      'search_read',
      [[]],
      kwargs: {
        'fields': ['id', 'department_name', 'name'],
        'limit': 100,
      },
    );

    if (deptResult is List && deptResult.isNotEmpty) {
      return List<Map<String, dynamic>>.from(
        deptResult.map(
          (d) => {
            'id': d['id'],
            'name': d['name'] ?? 'Unknown',
          },
        ),
      );
    }

    return [];
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    List<dynamic> catResult = [];

    try {
      catResult = await _svc.executeModelMethod(
        'job.category',
        'search_read',
        [[]],
        kwargs: {
          'fields': ['id', 'name'],
          'limit': 100,
        },
      );
    } catch (_) {
      catResult = await _svc.executeModelMethod(
        'hr.job.category',
        'search_read',
        [[]],
        kwargs: {
          'fields': ['id', 'name'],
          'limit': 100,
        },
      );
    }

    if (catResult is List && catResult.isNotEmpty) {
      return List<Map<String, dynamic>>.from(
        catResult.map(
          (c) => {
            'id': c['id'],
            'name': c['name'] ?? 'Unknown',
          },
        ),
      );
    }

    return [];
  }

 

  Future<int?> createRecruitment(
    Map<String, dynamic> payload,
  ) async {
    final created = await _svc.executeModelMethod(
      'hr.job.recruitment',
      'create',
      [payload],
    );

    if (created is int) return created;

    if (created is Map && created['id'] != null) {
      return created['id'];
    }

    return null;
  }

  static List<dynamic> many2manyIds(List<int> ids) => [6, 0, ids];

  Future<JobData?> createHrJob({
    required String title,
    int? departmentId,
    int? categoryId,
  }) async {
    final payload = <String, dynamic>{
      'name': title,
    };

    if (departmentId != null) {
      payload['department_id'] = departmentId;
    }

    if (categoryId != null) {
      payload['job_category'] = categoryId;
    }

    final created = await _svc.executeModelMethod(
      'hr.job',
      'create',
      [payload],
    );

    final jobId =
        created is int
            ? created
            : (created is Map && created['id'] != null)
            ? created['id']
            : null;

    if (jobId == null) {
      return null;
    }

    try {
      final recruitmentPayload = <String, dynamic>{
        'name': title,
        'job_id': jobId,
      };

      if (categoryId != null) {
        recruitmentPayload['job_category'] = categoryId;
      }

      final recruitmentId = await createRecruitment(recruitmentPayload);
      if (recruitmentId != null) {
        print('✅ Job card created with hr.job.recruitment id=$recruitmentId');
      } else {
        print('⚠️ hr.job.recruitment creation returned null');
      }
    } catch (e) {
      print('⚠️ Failed to create hr.job.recruitment card: $e');
    }

    final jobDetail = await _svc.executeModelMethod(
      'hr.job',
      'search_read',
      [
        [
          ['id', '=', jobId]
        ]
      ],
      kwargs: {
        'limit': 1,
        'fields': [
          'id',
          'name',
          'department_id',
          'job_category',
        ],
      },
    );

    if (jobDetail is List && jobDetail.isNotEmpty) {
      final job = jobDetail[0] as Map<String, dynamic>;

      final deptName = _extractName(job['department_id']);
      final categoryName = _extractName(job['job_category']);

      return JobData(
        id: jobId,
        title: job['name'] ?? 'Untitled',
        department: deptName,
        category: categoryName,
        experience: '',
        primarySkills: [],
        secondarySkills: [],
        location: '',
        salary: '',
        type: 'Full-time',
        status: 'Open',
        newCount: 0,
        description: '',
        responsibilities: [],
        requirements: [],
      );
    }

    return null;
  }

  static String _extractName(Object? value) {
    if (value is List && value.isNotEmpty) {
      final name = value.length > 1
          ? value[1]
          : value.first;

      return name?.toString() ?? 'N/A';
    }

    return value?.toString() ?? 'N/A';
  }

  Future<List<JobData>> fetchJobs({int limit = 200}) async {
    final result = await _svc.executeModelMethod(
      'hr.job',
      'search_read',
      [[]],
      kwargs: {
        'fields': ['id', 'name', 'department_id', 'job_category'],
        'limit': limit,
      },
    );

    if (result is List && result.isNotEmpty) {
      return List<JobData>.from(
        result.map(
          (raw) {
            final data = raw as Map<String, dynamic>;
            return JobData(
              id: data['id'] as int?,
              title: data['name']?.toString() ?? 'Untitled',
              department: _extractName(data['department_id']),
              category: _extractName(data['job_category']),
              experience: '',
              primarySkills: [],
              secondarySkills: [],
              location: '',
              salary: '',
              type: 'Full-time',
              status: 'Open',
              newCount: 0,
              description: '',
              responsibilities: [],
              requirements: [],
            );
          },
        ),
      );
    }

    return [];
  }
}
