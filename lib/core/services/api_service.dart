import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:opsento_ats/features/profile/model/model_class.dart';

class OdooService {
    final String database =
      "pmt_test";

  final String baseUrl =
      "https://test.ftprotech.in";
//  int? userId;
  // SINGLETON INSTANCE
  static final OdooService _instance =
      OdooService._internal();

  factory OdooService() {
    return _instance;
  }

  OdooService._internal() {

    client = OdooClient(
      "https://test.ftprotech.in",
    );
  }
final storage =
    const FlutterSecureStorage();
  // STORE USER ID
  static int? currentUserId;

  late OdooClient client;

  // LOGIN
// LOGIN
Future<dynamic> login({

  required String email,
  required String password,

}) async {

  final response =
      await client.authenticate(

    "pmt_test",

    email,

    password,
  );

  currentUserId =
      response.userId;

  // SAVE USER ID
  await storage.write(

    key: "user_id",

    value:
        currentUserId.toString(),
  );

  /// SAVE EMAIL
  await storage.write(

    key: "email",

    value: email,
  );

  /// SAVE PASSWORD
  await storage.write(

    key: "password",

    value: password,
  );

  /// SAVE DATABASE
  await storage.write(

    key: "db",

    value: "pmt_test",
  );

  /// SAVE BASE URL
  await storage.write(

    key: "baseUrl",

    value: "https://test.ftprotech.in",
  );

  /// SAVE SESSION ID
  await storage.write(

    key: "session_id",

    value: response.id,
  );

  /// SAVE LOGIN STATUS
  await storage.write(

    key: "is_logged_in",

    value: "true",
  );

  print(
    "USER ID => $currentUserId",
  );

  print(
    "SESSION ID => ${response.id}",
  );

  print(
    "DATABASE SAVED => pmt_test",
  );

  print(
    "BASE URL SAVED => https://test.ftprotech.in",
  );

  return response;
}
Future<void> autoLogin() async {

  final email =
      await storage.read(
    key: "email",
  );

  final password =
      await storage.read(
    key: "password",
  );

  if (email != null &&
      password != null) {

    try {

      await login(

        email: email,

        password: password,
      );

    } catch (e) {

      await storage.deleteAll();

      print(
        "AUTO LOGIN FAILED",
      );
    }
  }
}
Future<void> loadUserId() async {

  final userId =
      await storage.read(
    key: "user_id",
  );

  if (userId != null) {

    currentUserId =
        int.parse(userId);
  }

  print(
    "LOADED USER ID => $currentUserId",
  );
}
  // SIGNUP
  Future<dynamic> signup({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,

  }) async {
    final response = await client.callKw({
      'model': 'res.users',
      'method': 'create',
      'args': [
        {
          'name': name,
          'login': email,
          'email': email,
          'password': password,
          'confirmPassword':
              confirmPassword,
        }
      ],

      'kwargs': {},
    });

    return response;
  }

  // GET PROFILE
  Future<ProfileModel> getProfile() async {
// await autoLogin();

await loadUserId();  
 if (client.sessionId == null) {
    await autoLogin();

    // throw Exception(
    //   "Session Expired. Login Again",
    // );
  }
    final response =
        await client.callKw({

      'model': 'res.users',

      'method': 'read',

      'args': [

        [currentUserId]
      ],

      'kwargs': {

       'fields': [

  'name',
  'email',
  'phone',
  'company_id',
  'create_date',
  'job_title',
  'mobile',
  'image_1920',
],
      },
    });
  print(response);
    return ProfileModel.fromJson(
      response[0],
    );
  }

  // UPDATE PROFILE
  Future<void> updateProfile({

    required String name,
    required String email,
    required String phone,

  }) async {
  await loadUserId();

    print(
      "UPDATING USER => $currentUserId",
    );
    await client.callKw({

      'model': 'res.users',

      'method': 'write',

      'args': [

        [currentUserId],

        {

          'name': name,

          'email': email,

          'mobile': phone,
        }
      ],

      'kwargs': {},
    });
    
  }
  Future<dynamic> safeCallKw(
  Map<String, dynamic> payload,
) async {

  try {

    return await client.callKw(
      payload,
    );

  } on OdooSessionExpiredException {

    print(
      "SESSION EXPIRED => AUTO LOGIN",
    );

    await autoLogin();

    return await client.callKw(
      payload,
    );
  }
}
Future<void> loadSession() async {

  final sessionData =
      await storage.read(
    key: "session",
  );

  if (sessionData == null) {

    print(
      "NO SESSION FOUND",
    );

    return;
  }

  final session =
      OdooSession.fromJson(
    convertStringToMap(
      sessionData,
    ),
  );

  client = OdooClient(

    baseUrl,

    sessionId: session,
  );

  print(
    "SESSION RESTORED",
  );
}
Future<Map<String, dynamic>>
    getDashboardStats() async {

  try {

    final results =
        await Future.wait([

      /// TOTAL JOBS
      client.callKw({

        'model': 'hr.job.recruitment',

        'method': 'search_count',

        'args': [

          [
            ['user_id', '=', currentUserId]
          ]
        ],

        'kwargs': {},
      }),

      /// TOTAL APPLICANTS
      client.callKw({

        'model': 'hr.applicant',

        'method': 'search_count',

        'args': [

          [
            ['user_id', '=', currentUserId]
          ]
        ],

        'kwargs': {},
      }),

      /// HIRED
      client.callKw({

        'model': 'hr.applicant',

        'method': 'search_count',

        'args': [

          [

            ['user_id', '=', currentUserId],

            ['stage_id', '!=', false]
          ]
        ],

        'kwargs': {},
      }),
    ]);

    final jobsPosted =
        results[0];

    final applicants =
        results[1];

    final hired =
        results[2];

    print(
      "JOBS => $jobsPosted",
    );

    print(
      "APPLICANTS => $applicants",
    );

    print(
      "HIRED => $hired",
    );

    return {

      'jobsPosted':
          jobsPosted,

      'applicants':
          applicants,

      'hired':
          hired,

      'views': "0",
    };

  } catch (e) {

    print(
      "DASHBOARD ERROR",
    );

    print(e);

    return {

      'jobsPosted': 0,

      'applicants': 0,

      'hired': 0,

      'views': "0",
    };
  }
  
}
Map<String, dynamic>
    convertStringToMap(
  String data,
) {

  return Map<String, dynamic>.from(
    jsonDecode(data),
  );
}
}