import 'package:cluster/src/features/cluster/controller/agent_controller.dart';
import 'package:cluster/src/features/cluster/model/cluster.dart';
import 'package:flutter/material.dart';

import 'empty_list.dart';

class LoanList extends StatelessWidget {
  const LoanList(
      {Key? key,
      this.text,
      this.length,
      required this.agent,
      required this.loan})
      : super(key: key);

  final Data? agent;
  final String? text;
  final int? length;
  final bool? loan;

  @override
  Widget build(BuildContext context) {
    return loan != null && loan!
        ? EmptyList(text: text!)
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox();
            },
          );
  }
}

class Loans extends StatelessWidget {
  const Loans({
    Key? key,
    required this.overdue,
    required this.text,
    required this.showdueLoan,
    this.onPressed,
  }) : super(key: key);

  final AgentController overdue;
  final String text;
  final bool showdueLoan;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(text),
        ),
        IconButton(
          onPressed: onPressed,
          icon: showdueLoan ? Icon(Icons.add) : Icon(Icons.remove),
        ),
      ],
    );
  }
}
