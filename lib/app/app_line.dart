import 'package:c9p/app/theme/colors.dart';
import 'package:flutter/cupertino.dart';

class AppLineWidget extends StatelessWidget {
  final Color? color;

  const AppLineWidget({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 0.5,
        color: color ?? colorLine,
      ),
    );
  }
}
