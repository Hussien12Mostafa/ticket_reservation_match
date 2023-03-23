import 'package:flutter/material.dart';

class FooterItem extends StatefulWidget {
  final String title;
  final bool isHovering;
  final Color textColor;
  const FooterItem(this.title, this.isHovering, this.textColor);

  @override
  _FooterItemState createState() => _FooterItemState();
}

class _FooterItemState extends State<FooterItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 15,
              color: widget.isHovering
                  ? widget.textColor.withOpacity(0.8)
                  : widget.textColor,
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(height: 30, child: VerticalDivider()),
        SizedBox(width: 10),
      ],
    );
  }
}
