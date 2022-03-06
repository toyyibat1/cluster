import 'package:cluster/src/core/constants/app_spacing.dart';
import 'package:cluster/src/core/constants/app_textstyle.dart';
import 'package:cluster/src/core/constants/colors.dart';
import 'package:cluster/src/features/cluster/providers/cluster_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_elevated_button.dart';

class TopHeaderContainer extends ConsumerWidget {
  const TopHeaderContainer({this.height, Key? key}) : super(key: key);

  final double? height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(agentProvider);
    final agent = data.value?.data;

    var rate = agent?.clusterRepaymentRate;
    return agent == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: AppColors.onBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agent.clusterName ?? '',
                  style: kText,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Repayment rate: ${rate! * 100} %",
                      style: kBodyText1TextStyle,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Image border
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(22), // Image radius
                        child: Image.network(
                            'https://i0.wp.com/austinemedia.com/wp-content/uploads/2018/10/1-8.jpg?resize=642%2C642&ssl=1',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
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
          );
  }
}
