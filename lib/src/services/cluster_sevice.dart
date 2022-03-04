import 'dart:convert';

import 'package:cluster/src/core/network/api_base_helper.dart';
import 'package:cluster/src/features/cluster/model/cluster.dart';

class ClusterService {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Cluster> getAgent() async {
    print("Staart1");

    final loanResponse = await _helper.get(
      "loans",
    );

    return Cluster.fromJson(loanResponse);
  }

  Future<List<ActiveAgent>> getActiveLoan() async {
    final response = await _helper.get(
      "loans",
    );

    return List<ActiveAgent>.from(
      response['data']['active_agents'].map(
        (response) => ActiveAgent.fromJson(response),
      ),
    );
  }

  Future<List<InActiveAgent>> getInActiveLoan() async {
    final response = await _helper.get(
      "loans",
    );

    return List<InActiveAgent>.from(
      response['data']['inactive_agents'].map(
        (response) => InActiveAgent.fromJson(response),
      ),
    );
  }
}
