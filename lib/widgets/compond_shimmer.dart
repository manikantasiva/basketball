import 'package:flutter/material.dart';
import 'package:bb_sports/widgets/common_shimmer_card.dart';

class CompondShimmerWidget extends StatelessWidget {
  const CompondShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          CommonShimmerCard(height: 60, margin: 16),
          SizedBox(height: 16),
          CommonShimmerCard(height: 110, margin: 16),
          SizedBox(height: 32),
          CommonShimmerCard(height: 100, margin: 16),
          SizedBox(height: 16),
          CommonShimmerCard(height: 100, margin: 16),
        ],
      ),
    );
  }
}
