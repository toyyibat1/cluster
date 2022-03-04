import 'package:cluster/src/features/cluster/model/cluster.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cluster_repository_provider.dart';

final agentProvider = FutureProvider<Cluster>((ref) async {
  return ref.watch(agentRepositoryProvider).getAgent();
});

final activeLoanProvider = FutureProvider<List<ActiveAgent>?>((ref) async {
  return ref.watch(agentRepositoryProvider).getActiveLoan();
});

final inactiveLoanProvider = FutureProvider<List<InActiveAgent>?>((ref) async {
  return ref.watch(agentRepositoryProvider).getInActiveLoan();
});
