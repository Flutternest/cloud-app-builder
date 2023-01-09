import 'package:automation_wrapper_builder/services/http/http_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dio_http_service.dart';

final httpServiceProvider = Provider<HttpService>((ref) {
  return DioHttpService();
});
