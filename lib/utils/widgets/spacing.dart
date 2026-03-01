import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class YMargin extends StatelessWidget {
  final double space;

  const YMargin(this.space, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space.h,
    );
  }
}

class XMargin extends StatelessWidget {
  final double space;

  const XMargin(this.space, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: space.w,
    );
  }
}
