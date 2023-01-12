import 'package:automation_wrapper_builder/controllers/top_level_providers.dart';
import 'package:automation_wrapper_builder/data/models/build_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyListProvider = StreamProvider<Iterable<BuildItem>>((ref) async* {
  final snapshots = ref
      .watch(firestoreProvider)
      .collection("history")
      .snapshots()
      .asBroadcastStream()
      .map(
        (event) => event.docs.map((element) {
          return BuildItem.fromJson(element.data());
        }),
      );

  await for (final shot in snapshots) {
    yield shot;
  }
});
