import 'package:automation_wrapper_builder/controllers/core/prefs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_configs.dart';
import '../services/http/http_service.dart';
import '../services/http/http_service_provider.dart';

final buildsRepositoryProvider = Provider<BuildsRepository>((ref) {
  final http = ref.watch(httpServiceProvider);
  final prefs = ref.watch(prefsProvider);

  return BuildsRepository(http, prefs);
});

class BuildsRepository {
  final HttpService httpService;
  final SharedPreferences prefsProvider;

  BuildsRepository(this.httpService, this.prefsProvider);

  String get path => Configs.apiBaseUrl;

  /// Add a new build
  ///
  /// [recordId] - The record id of the build (if update, else leave null)
  Future<void> addOrUpdatedNewBuild({
    String? recordId,
  }) async {}
}
