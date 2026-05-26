import 'package:opsento_ats/core/services/odoo_service.dart';
import 'package:opsento_ats/core/constants/api_config.dart';
class DashboardRepository {

  Future<Map<String, dynamic>>
      getDashboardStats() async {

    /// LOAD SESSION (handled by OdooService singleton or prefs)

    /// RECRUITER NAME
    String name = "";

    try {

      final user =
          await OdooService(ApiConfig.baseUrl).callKw({

        'model': 'res.users',

        'method': 'search_read',

        'args': [
          [
            [
              'id',
              '=',
              OdooService.currentUserId
            ]
          ]
        ],

        'kwargs': {
          'fields': ['name'],
          'limit': 1,
        },
      });

      print("USER DATA => $user");

      name = user[0]['name'];

      print(
        "RECRUITER NAME => $name",
      );

    } catch (e) {

      print(
        "USER ERROR => $e",
      );
    }

    /// DASHBOARD COUNTS
    final results =
        await Future.wait([

      /// OPEN POSITIONS
      OdooService(ApiConfig.baseUrl).callKw({

        'model': 'hr.job.recruitment',

        'method': 'search_count',

        'args': [
          [
            [
              'user_id',
              '=',
              OdooService.currentUserId
            ]
          ]
        ],

        'kwargs': {},
      }),

      /// APPLICATIONS
      OdooService(ApiConfig.baseUrl).callKw({

        'model': 'hr.applicant',

        'method': 'search_count',

        'args': [
          [
            [
              'user_id',
              '=',
              OdooService.currentUserId
            ]
          ]
        ],

        'kwargs': {},
      }),

      /// INTERVIEWS
      OdooService(ApiConfig.baseUrl).callKw({

        'model': 'hr.applicant',

        'method': 'search_count',

        'args': [
          [
            [
              'stage_id.name',
              '=',
              'Interview'
            ],
            [
              'user_id',
                       'ilike',

              OdooService.currentUserId
            ]
          ]
        ],

        'kwargs': {},
      }),

      /// OFFERS
      OdooService(ApiConfig.baseUrl).callKw({

        'model': 'hr.applicant',

        'method': 'search_count',

        'args': [
          [
            [
              'stage_id.name',
                        'ilike',

              'Offer'
            ],
            [
              'user_id',
              '=',
              OdooService.currentUserId
            ]
          ]
        ],

        'kwargs': {},
      }),

      /// HIRED
      OdooService(ApiConfig.baseUrl).callKw({

        'model': 'hr.applicant',

        'method': 'search_count',

        'args': [
          [
            [
              'stage_id.name',
                        'ilike',

              'Hired'
            ],
            [
              'user_id',
              '=',
              OdooService.currentUserId
            ]
          ]
        ],

        'kwargs': {},
      }),

      /// REJECTED
      OdooService(ApiConfig.baseUrl).callKw({

        'model': 'hr.applicant',

        'method': 'search_count',

        'args': [
          [
            [
              'stage_id.name',
                       'ilike',

              'Rejected'
            ],
            [
              'user_id',
              '=',
              OdooService.currentUserId
            ]
          ]
        ],

        'kwargs': {},
      }),
    ]);

    print(
      "RESULTS => $results",
    );

    /// DYNAMIC VALUES
    final applied =
        results[1];

    final interviews =
        results[2];

    final offers =
        results[3];

    final hired =
        results[4];

    final rejected =
        results[5];

    return {

      'recruiterName': name,

      'counts': [

        results[0], // Open Positions

        applied,

        interviews,

        offers,

        hired,

        rejected,
      ],

      /// REAL HIRING FUNNEL
      'chartValues': [

        applied.toDouble(),

        interviews.toDouble(),

        offers.toDouble(),

        hired.toDouble(),

        rejected.toDouble(),
      ],
    };
  }
}
