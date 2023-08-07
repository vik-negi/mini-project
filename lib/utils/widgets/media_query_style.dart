import 'package:flutter/material.dart';

class MediaQueryStyle extends StatelessWidget {
  final List<Widget> children;
  final bool isColumn;
  final CrossAxisAlignment? rowCrossAxisAlignment;
  final CrossAxisAlignment? columnCrossAxisAlignment;
  final MainAxisAlignment? rowMainAxisAlignment;
  final MainAxisAlignment? columnMainAxisAlignment;
  const MediaQueryStyle({
    super.key,
    required this.children,
    required this.isColumn,
    this.rowCrossAxisAlignment,
    this.columnCrossAxisAlignment,
    this.rowMainAxisAlignment,
    this.columnMainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return isColumn
        ? Column(
            crossAxisAlignment:
                columnCrossAxisAlignment ?? CrossAxisAlignment.center,
            mainAxisAlignment:
                columnMainAxisAlignment ?? MainAxisAlignment.start,
            children: children,
          )
        : Row(
            mainAxisAlignment: rowMainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment:
                rowCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: children,
          );
  }
}
