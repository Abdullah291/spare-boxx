import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sparebboxx/utils/constant.dart';

class LoadingIndicator extends StatelessWidget {
   const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: const SpinKitCubeGrid(
          color: kPrimary,
          size: 70.0,
        ),
      ),
    );
  }
}
