import 'package:odoo_rpc/odoo_rpc.dart';

class OdooService {

  late OdooClient client;

  OdooService() {

    client = OdooClient(
      "https://test.ftprotech.in",
    );
  }

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

    return response;
  }

  // SIGNUP
  Future<dynamic> signup({

    required String name,
    required String email,
    required String password,
    required String confirmPassword,


  }) async {
    
  // await client.authenticate(

  //   "pmt_test",

  //   "admin@gmail.com",

  //   "admin123",
  // );
    final response =
        await client.callKw(

      {

        'model': 'res.users',

        'method': 'create',

        'args': [

          {

            'name': name,

            'login': email,

            'email': email,

            'password': password,

            'confirmPassword' : confirmPassword,
          }
        ],

        'kwargs': {},
      },
    );

    return response;
  }
   Future<dynamic> getProfile() async {

    final response =
        await client.callKw({

      'model': 'res.users',

      'method': 'search_read',

      'args': [],

      'kwargs': {

        'fields': [

          'name',
          'email',
          'phone',
          'company_id',
          'create_date',
        ],
      },
    });

    return response;
  }
}