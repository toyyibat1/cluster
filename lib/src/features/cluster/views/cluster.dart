import 'package:cluster/src/core/constants/app_spacing.dart';
import 'package:cluster/src/core/constants/app_textstyle.dart';
import 'package:cluster/src/core/constants/colors.dart';
import 'package:cluster/src/features/cluster/controller/agent_controller.dart';
import 'package:cluster/src/features/cluster/model/cluster.dart';
import 'package:cluster/src/features/providers/cluster_provider.dart';
import 'package:cluster/src/features/providers/cluster_repository_provider.dart';
import 'package:cluster/src/widgets/app_elevated_button.dart';
import 'package:cluster/src/widgets/custom_app_bar.dart';
import 'package:cluster/src/widgets/empty_list.dart';
import 'package:cluster/src/widgets/loan.dart';
import 'package:cluster/src/widgets/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cluster_details.dart';
import 'member.dart';

class MyCluster extends HookConsumerWidget {
  const MyCluster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = useState(0);

    final data = ref.watch(agentProvider);
    final agent = data.value?.data;

    var value = agent!.clusterRepaymentRate! * 100;

    var totalAgent = agent.overdueAgents!.length +
        agent.dueAgents!.length +
        agent.activeAgents!.length +
        agent.inactiveAgents!.length;

    return Scaffold(
      appBar: const CustomAppBar(
        title: " My cluster",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.47,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: AppColors.onBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    agent.clusterName ?? '',
                    style: kText,
                  ),
                  kTinyVerticalSpacing,
                  Text(
                    "Repayment rate: ${value.toInt()} %",
                    style: kBodyText1TextStyle,
                  ),
                  kTinyVerticalSpacing,
                  Text("Replayment Day: Every ${agent.clusterRepaymentDay}",
                      style: kBodyText1TextStyle),
                  kLargeVerticalSpacing,
                  Text(
                    'Cluster purse balance',
                    style: kSmallText,
                  ),
                  Row(
                    children: [
                      Text(
                        'N${agent.clusterPurseBalance.toString()}',
                        style: kText,
                      ),
                      Spacer(),
                      AppElevatedButton(label: "View Purse")
                    ],
                  ),
                  Text(
                    'N${agent.totalInterestEarned.toString()} interest today',
                    style: kGreenText,
                  ),
                  kMediumVerticalSpacing,
                  Divider(
                    color: Colors.white,
                  ),
                  kTinyVerticalSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total interest earned',
                        style: kBodyText1TextStyle,
                      ),
                      Text('N${agent.totalInterestEarned.toString()}',
                          style: TextStyle(color: Colors.yellow)),
                    ],
                  ),
                  kTinyVerticalSpacing,
                  Divider(
                    color: Colors.white,
                  ),
                  kTinyVerticalSpacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total owed by members',
                        style: kBodyText1TextStyle,
                      ),
                      Text(
                        'N${agent.totalOwedByMembers.toString()}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CupertinoSlidingSegmentedControl(
                  backgroundColor: Colors.white,
                  groupValue: selectedItem.value,
                  thumbColor: Colors.red.shade400,
                  children: {
                    0: Container(
                      height: 36,
                      child: Center(child: Text('Members ( ${totalAgent} )')),
                    ),
                    1: Container(
                      height: 36,
                      child: Center(child: Text('Cluster Details')),
                    ),
                  },
                  onValueChanged: (int? value) => selectedItem.value = value!,
                ),
              ),
              Spacing.mediumHeight(),
              selectedItem.value == 0 ? Members() : ClusterDetails()
            ])
          ],
        ),
      ),
    );
  }
}
