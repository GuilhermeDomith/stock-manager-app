
import 'package:flutter_dotenv/flutter_dotenv.dart';


class Config {

  static final baseUrl = DotEnv().env['APP_BASE_URL'];

}