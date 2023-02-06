import 'package:automation_wrapper_builder/controllers/core/prefs_provider.dart';
import 'package:automation_wrapper_builder/data/models/build_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_configs.dart';
import '../services/http/http_service.dart';
import '../services/http/http_service_provider.dart';

final builderRepositoryProvider = Provider<BuilderRepository>((ref) {
  final http = ref.watch(httpServiceProvider);
  final prefs = ref.watch(prefsProvider);

  return BuilderRepository(http, prefs);
});

class BuilderRepository {
  final HttpService httpService;
  final SharedPreferences prefsProvider;

  BuilderRepository(this.httpService, this.prefsProvider);

  String get path => Configs.apiBaseUrl;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await httpService.post(
      "$path/login",
      data: FormData.fromMap({
        "email": email,
        "password": password,
      }),
    );
  }

  /// Add a new build
  ///
  /// [recordId] - The record id of the build (if update, else leave null)
  Future<void> addOrUpdatedNewBuild({
    String? recordId,
    required Map<String, dynamic> rawData,
    required Map<String, MultipartFile> filesData,
  }) async {
    final finalMap = <String, dynamic>{};
    finalMap.addAll(rawData);
    finalMap.addAll(filesData);

    if (recordId != null) {
      finalMap.addAll({"id": recordId});
    }

    await httpService.post(
      "$path/create/flutter/async",
      data: FormData.fromMap(finalMap),
    );
  }
}
