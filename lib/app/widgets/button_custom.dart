
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String toolTip;
  final GestureTapCallback onPress;
  final Widget child;
  final BorderRadius? borderRadius;

  ButtonCustom(
      {required this.toolTip,
        required this.onPress,
        required this.child,
        this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            child: Material(
              color: Colors.transparent,
              child: Tooltip(
                message: toolTip,
                child: InkWell(
                  onTap: onPress,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}