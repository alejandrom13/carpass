import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String baseApiUrl = dotenv.env['BASE_API_URL'] ?? '';
}
