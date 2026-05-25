import 'package:opsento_ats/core/services/api_service.dart';

class DashboardRepository {

  Future<Map<String, dynamic>>
      getDashboardStats() async {

    /// LOAD SESSION
    await OdooService()
        .loadSession();

    /// LOAD USER ID
    await OdooService()
        .loadUserId();

    /// RECRUITER NAME
    String name = "";

    try {

      final user =
          await OdooService()
              .client
              .callKw({

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
      OdooService()
          .client
          .callKw({

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
      OdooService()
          .client
          .callKw({

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
      OdooService()
          .client
          .callKw({

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
      OdooService()
          .client
          .callKw({

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
      OdooService()
          .client
          .callKw({

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
      OdooService()
          .client
          .callKw({

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