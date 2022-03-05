import 'package:cluster/src/repositories/cluster_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final agentRepositoryProvider =
    Provider<ClusterRepository>((ref) => ClusterRepository());
