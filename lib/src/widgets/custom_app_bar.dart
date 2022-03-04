import 'package:cluster/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'spacing.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? circleAvatar;
  final String? title;
  final Color? backgroundColor;
  final Widget? text;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.trailing,
    this.title,
    this.backgroundColor,
    this.circleAvatar,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var parentRoute = ModalRoute.of(context);

    return AppBar(
      leading: Icon(Icons.arrow_back, color: Colors.white),

      // : null),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.onBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: Row(
        children: [
          Spacing.mediumWidth(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title ?? '',
                  // style: Theme.of(context).textTheme.headline6,
                ),
                Spacing.smallHeight(),
                text ?? Spacing.empty(),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor ?? AppColors.onBackgroundColor,
      elevation: 0,
      actions: [trailing ?? Spacing.empty()],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
