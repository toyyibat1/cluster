import 'package:cluster/src/core/constants/app_spacing.dart';
import 'package:cluster/src/features/cluster/controller/agent_controller.dart';
import 'package:cluster/src/features/cluster/providers/cluster_provider.dart';
import 'package:cluster/src/widgets/empty_list.dart';
import 'package:cluster/src/widgets/loan.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Members extends ConsumerWidget {
  const Members({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(agentProvider);
    final overdue = ref.watch(agentControllerProvider);
    final agent = data.value?.data;
    final activeloan = ref.watch(activeLoanProvider);
    final inactiveloan = ref.watch(inactiveLoanProvider);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(children: [
        Loans(
          overdue: overdue,
          text: "Over Due Loans",
          showdueLoan: overdue.showoverdueLoanVisible,
          onPressed: overdue.toggleOverdueLoanVisibilty,
        ),
        !overdue.showoverdueLoanVisible
            ? LoanList(
                agent: agent,
                text: "You do not have over due Loan",
                length: agent?.overdueAgents?.length,
                loan: agent?.overdueAgents?.isEmpty,
              )
            : SizedBox.shrink(),
        Divider(),
        Loans(
          overdue: overdue,
          text: "Due Today",
          showdueLoan: overdue.showdueLoanVisible,
          onPressed: overdue.toggledueLoanVisibilty,
        ),
        !overdue.showdueLoanVisible
            ? LoanList(
                agent: agent,
                text: "You do not have due Loan",
                length: agent?.dueAgents?.length,
                loan: agent?.dueAgents?.isEmpty,
              )
            : SizedBox.shrink(),
        Divider(),
        Loans(
          overdue: overdue,
          text: "Active Loans",
          showdueLoan: overdue.showactiveLoanVisible,
          onPressed: overdue.toggleactiveLoanVisibilty,
        ),
        !overdue.showactiveLoanVisible
            ? activeloan.when(
                data: (data) => ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    int daysBetween(DateTime from, DateTime to) {
                      from = DateTime(from.year, from.month, from.day);
                      to = DateTime(to.year, to.month, to.day);
                      return (to.difference(from).inHours / 24).round();
                    }

                    final today =
                        data[index].agent!.recentLoan!.agentLoan!.loanDueDate;
                    final date2 = DateTime.now();
                    final difference = daysBetween(date2, today!);
                    return Container(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(38), // Image radius
                              child: Image.network(
                                  'https://i0.wp.com/austinemedia.com/wp-content/uploads/2018/10/1-8.jpg?resize=642%2C642&ssl=1',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          kMediumHorizontalSpacing,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                      '${data[index].agent!.firstName} ${data[index].agent!.lastName}'),
                                  kTinyHorizontalSpacing,
                                  Text('*'),
                                  kTinyHorizontalSpacing,
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '${difference.toString()} days to due date',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              kSmallVerticalSpacing,
                              Text(
                                  'N${data[index].agent!.recentLoan!.loanAmount} Active loan'),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                error: (_, __) => ErrorList(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox.shrink(),
        Divider(),
        Loans(
          overdue: overdue,
          text: "inActive Loans",
          showdueLoan: overdue.showinactiveLoanVisible,
          onPressed: overdue.toggleinactiveLoanVisibilty,
        ),
        !overdue.showinactiveLoanVisible
            ? inactiveloan.when(
                data: (data) => ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    // data[index].agent.recentLoan.agentLoan.loanDueDate
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(38), // Image radius
                              child: Image.network(
                                  'https://i0.wp.com/austinemedia.com/wp-content/uploads/2018/10/1-8.jpg?resize=642%2C642&ssl=1',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          kMediumHorizontalSpacing,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${data[index].agent!.firstName} ${data[index].agent!.lastName}'),
                              kSmallVerticalSpacing,
                              Text('No Active Loan'),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                error: (_, __) => ErrorList(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox.shrink(),
        kLargeVerticalSpacing,
      ]),
    );
  }
}
