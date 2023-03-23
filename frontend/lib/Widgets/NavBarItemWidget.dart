import 'package:flutter/material.dart';

class NavBarItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isHovering;
  final Color textColor;
  const NavBarItem(this.title, this.icon, this.isHovering, this.textColor);

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Icon(
            widget.icon,
            color: widget.isHovering
                ? widget.textColor.withOpacity(0.8)
                : widget.textColor,
          ),
        ),
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
