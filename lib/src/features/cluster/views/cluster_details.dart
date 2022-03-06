import 'package:cluster/src/core/constants/app_spacing.dart';
import 'package:cluster/src/core/constants/app_textstyle.dart';
import 'package:cluster/src/features/cluster/providers/cluster_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClusterDetails extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cluster = ref.watch(agentProvider);
    final clusterd = cluster.value!.data;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle_notifications),
              TextButton(
                onPressed: () {},
                child: TextValue(
                  text: 'Cluster purse setting',
                  kstyle: kMediumText,
                ),
              ),
            ],
          ),
          TextValue(text: 'Frequency of Contribution'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextValue(
                text: 'Monthly upfront',
                kstyle: kLabelText,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Change',
                  style: kRedText,
                ),
              ),
            ],
          ),
          TextValue(
            text: 'N${clusterd?.clusterPurseBalance.toString()}',
            kstyle: kMediumText,
          ),
          TextValue(
            text:
                'Your contribution is ${clusterd?.clusterRepaymentRate} of your eligible amount',
            kstyle: kMediumLabelText,
          ),
          kTinyVerticalSpacing,
          Divider(),
          kTinyVerticalSpacing,
          Row(
            children: [
              Icon(Icons.link),
              TextButton(
                  onPressed: () {},
                  child: TextValue(
                    text: 'Group invite Link/Code',
                    kstyle: kMediumText,
                  )),
            ],
          ),
          TextValue(
            text: 'Use the link code below to invite new member',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextValue(text: 'Member invite code'),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Get new code',
                    style: kRedText,
                  )),
            ],
          ),
          TextValue(text: '30DDF38TGOOO'),
          kTinyVerticalSpacing,
          Divider(),
          kTinyVerticalSpacing,
          Row(
            children: [
              Icon(Icons.menu),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Loan setting',
                  style: kMediumText,
                ),
              ),
            ],
          ),
          TextValue(
            text: 'Total loan collectd by cluster',
          ),
          kSmallVerticalSpacing,
          TextValue(text: 'N${clusterd?.clusterPurseBalance.toString()}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextValue(text: 'Repayment Day'),
              TextButton(
                onPressed: () {},
                child: TextValue(text: 'Change', kstyle: kRedText),
              )
            ],
          ),
          TextValue(text: 'Every ${clusterd?.clusterRepaymentDay.toString()}'),
          kTinyVerticalSpacing,
          Divider(),
          kTinyVerticalSpacing,
          Row(
            children: [
              Icon(Icons.menu),
              TextButton(
                  onPressed: () {},
                  child: Text('Pending Join request', style: kMediumText)),
            ],
          ),
          TextValue(text: 'No pending cluster join request'),
          kTinyVerticalSpacing,
          Divider(),
          kTinyVerticalSpacing,
          Row(
            children: [
              Icon(Icons.circle_notifications),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Group settings',
                  style: kMediumText,
                ),
              ),
            ],
          ),
          TextValue(text: 'Group rules'),
          kSmallVerticalSpacing,
          TextValue(
            text:
                '1. Check the cars rental terms as well, because each company has its own rules.',
          ),
          TextValue(
            text:
                '2. Check the cars rental terms as well, because each company has its own rules.',
          ),
          kMediumVerticalSpacing,
          TextValue(text: 'Group Whatsapp'),
          TextValue(
            text: 'https://chat.watsapp.com/BmK1mYu9zGAGhhqi8xqQQQ5',
            kstyle: kGreenText,
          ),
          Row(
            children: [
              Icon(Icons.edit, color: Colors.red[100]),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Edit settings',
                  style: kRedText,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(Icons.event_note),
              TextButton(
                  onPressed: () {},
                  child: Text('Benefits earned', style: kMediumText)),
            ],
          ),
          TextValue(text: 'Total CH benfits earned'),
          kSmallVerticalSpacing,
          TextValue(text: 'N${clusterd?.clusterPurseBalance.toString()}'),
          kSmallVerticalSpacing,
          TextValue(text: 'Available Benefits'),
          kSmallVerticalSpacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextValue(text: 'N${clusterd?.clusterPurseBalance.toString()}'),
              TextValue(
                  text: '+ N${clusterd?.clusterPurseBalance.toString()} Today'),
            ],
          ),
          Row(
            children: [
              Icon(Icons.edit, color: Colors.red[100]),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View earning history',
                  style: kRedText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextValue extends StatelessWidget {
  const TextValue({Key? key, this.text, this.kstyle}) : super(key: key);

  final String? text;
  final TextStyle? kstyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: kstyle,
    );
  }
}
