import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Key key;
  final String text;
  final double width;
  final double height;
  final VoidCallback onPressed;
  final BorderRadius borderRadius;
  final bool disabled;

  Button(this.text,
      {@required this.key,
      this.width = 160,
      this.height = 45,
      @required this.onPressed,
      this.borderRadius,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: disabled ? Theme.of(context).primaryColor.withOpacity(0.4) : Theme.of(context).primaryColor,
          borderRadius: borderRadius,
        ),
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FlatButton(
          key: key,
          onPressed: disabled ? null : onPressed,
          child: Text(
            text,
            textScaleFactor: 1,
            style: Theme.of(context).textTheme.button,
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
        ),
      ),
    );
  }
}
