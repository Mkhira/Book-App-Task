




import 'package:flutter/material.dart';

class ShakeTransition extends StatelessWidget {
  ShakeTransition({this.duration= const Duration(milliseconds: 1200),this.child,this.offset =180,this.axis = Axis.horizontal});
  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      child: child,
      duration: duration,
      curve: Curves.elasticOut,

      tween: Tween(begin: 1.0,end: 0.0),
      builder: (context, value ,child){
        return Transform.translate(offset:
          axis == Axis.horizontal ?
        Offset(value* offset, 0.0) :Offset(0.0, value*offset),
        child: child,
        );
      },
    );
  }
}
