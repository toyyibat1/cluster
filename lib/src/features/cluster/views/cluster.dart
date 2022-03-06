import 'package:cluster/src/core/constants/app_responsive.dart';
import 'package:cluster/src/core/constants/app_spacing.dart';
import 'package:cluster/src/core/constants/app_textstyle.dart';
import 'package:cluster/src/core/constants/colors.dart';
import 'package:cluster/src/features/cluster/controller/agent_controller.dart';
import 'package:cluster/src/features/cluster/providers/cluster_provider.dart';
import 'package:cluster/src/widgets/app_elevated_button.dart';
import 'package:cluster/src/widgets/custom_app_bar.dart';
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
    final _controller = useTabController(initialLength: 2);
    final _scrollController = useScrollController();
    final _index = useState(0);
    final _key = GlobalKey();
    bool? fixedScroll;

    _controller.addListener(() {
      _index.value = _controller.index;
    });

    _scrollController.addListener(() {
      if (fixedScroll == false) {
        _scrollController.jumpTo(0);
      }
      _scrollController.animateTo(
        0,
        duration: Duration(microseconds: 300),
        curve: Curves.ease,
      );
      fixedScroll = _controller.index == 1;
    });

    final data = ref.watch(agentProvider);
    final agent = data.value?.data;

    var overdueloan = agent?.overdueAgents?.length ?? 0;
    var dueloan = agent?.dueAgents?.length ?? 0;
    var activeloan = agent?.inactiveAgents?.length ?? 0;
    var inactiveloan = agent?.activeAgents?.length ?? 0;

    var totalAgent = overdueloan + dueloan + activeloan + inactiveloan;
    var rate = agent?.clusterRepaymentRate;

    return Scaffold(
        appBar: const CustomAppBar(title: " My cluster"),
        body: agent == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              )
            : NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, value) {
                  return [
                    SliverToBoxAdapter(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.47,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                  borderRadius:
                                      BorderRadius.circular(10), // Image border
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(22), // Image radius
                                    child: Image.network(
                                        'https://i0.wp.com/austinemedia.com/wp-content/uploads/2018/10/1-8.jpg?resize=642%2C642&ssl=1',
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                                "Replayment Day: Every ${agent.clusterRepaymentDay}",
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
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        child: TabBar(
                          onTap: (value) {
                            _controller.animateTo(_index.value = value);
                          },
                          controller: _controller,
                          indicatorColor: Colors.red[200],
                          labelColor: Colors.red[200],
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                              text: 'Members ( ${totalAgent} )',
                            ),
                            Tab(
                              text: 'Cluster Details',
                            ),
                          ],
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(
                  key: _key,
                  controller: _controller,
                  children: <Widget>[
                    Members(),
                    ClusterDetails(),
                  ],
                ),
              ));
  }
}
