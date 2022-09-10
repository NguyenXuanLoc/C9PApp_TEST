import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class AppRefreshWidget extends StatelessWidget {
  final Widget body;
  final VoidCallback onRefresh;

  const AppRefreshWidget(
      {Key? key, required this.body, required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: colorGreen60,
        child: body,
        onRefresh: () async => onRefresh.call());
  }
}
