import 'package:cluster/src/features/cluster/providers/cluster_provider.dart';
import 'package:cluster/src/widgets/custom_app_bar.dart';
import 'package:cluster/src/widgets/top_header_container.dart';
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
    final _index = useState(0);
    final _key = GlobalKey();

    var hasPageChange =
        MediaQuery.of(context).orientation == Orientation.landscape;

    _controller.addListener(() {
      _index.value = _controller.index;
    });

    final data = ref.watch(agentProvider);
    final agent = data.value?.data;

    var overdueloan = agent?.overdueAgents?.length ?? 0;
    var dueloan = agent?.dueAgents?.length ?? 0;
    var activeloan = agent?.inactiveAgents?.length ?? 0;
    var inactiveloan = agent?.activeAgents?.length ?? 0;
    var totalAgent = overdueloan + dueloan + activeloan + inactiveloan;

    return Scaffold(
      appBar: const CustomAppBar(title: " My cluster"),
      body: agent == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            )
          : NestedScrollView(
              physics: ScrollPhysics(),
              // controller: _scrollController,
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(
                      child: hasPageChange
                          ? AspectRatio(
                              aspectRatio: 2.1,
                              child: TopHeaderContainer(
                                height: MediaQuery.of(context).size.height,
                              ),
                            )
                          : AspectRatio(
                              aspectRatio: 1.2,
                              child: TopHeaderContainer(
                                height: MediaQuery.of(context).size.height,
                              ),
                            )),
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
            ),
    );
  }
}
