// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmerCard extends StatelessWidget {
  final double height;
  final double margin;

  const CommonShimmerCard({
    super.key,
    required this.height,
    this.margin = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin),
      child: Shimmer.fromColors(
        baseColor: Colors.transparent.withOpacity(0.09),
        highlightColor: Colors.transparent.withOpacity(0.09),
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
