import 'package:flutter/material.dart';

Widget buildResponsiveGrid(BuildContext context, List<Widget> items) {
  double screenWidth = MediaQuery.of(context).size.width;
  int crossAxisCount = screenWidth > 600 ? 4 : 2;

  return GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: crossAxisCount,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 1.6,
    children: items,
  );
}
