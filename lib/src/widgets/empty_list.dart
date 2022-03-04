import 'package:cluster/src/core/constants/images.dart';
import 'package:flutter/material.dart';

import 'spacing.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      // style: theme.textTheme.subtitle2,
      textAlign: TextAlign.center,
    );
  }
}

class ErrorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Column(
        children: [
          Text(
            'Something went wrong!',
            style: theme.textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
          Spacing.tinyHeight(),
          Text(
            'Can\t load items right now',
            style: theme.textTheme.subtitle1,
          ),
          Spacing.largeHeight(),
        ],
      ),
    );
  }
}
