import 'dart:io';

import 'package:cluster/src/features/cluster/model/cluster.dart';
import 'package:cluster/src/services/cluster_sevice.dart';
import 'package:flutter/cupertino.dart';

class ClusterRepository {
  final service = ClusterService();

  Future<Cluster> getAgent() async {
    final response = await service.getAgent();

    return response;
  }

  Future<List<ActiveAgent>?> getActiveLoan() async {
    final response = await service.getActiveLoan();
    print(response);
    return response;
  }

  Future<List<InActiveAgent>?> getInActiveLoan() async {
    final response = await service.getInActiveLoan();
    print(response);
    return response;
  }
}
