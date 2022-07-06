import 'package:flutter/material.dart';

class RatingOverlay extends StatelessWidget {
  final double rating;
  const RatingOverlay({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      padding: const EdgeInsets.only(left: 5, right: 7, top: 4, bottom: 4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.star, color: Colors.yellow, size: 15),
          const SizedBox(width: 2),
          Text('$rating'),
        ],
      ),
    );
  }
}

class AltRatingOverlay extends StatelessWidget {
  final double rating;
  final int ratingCount;

  const AltRatingOverlay({
    Key? key,
    required this.rating,
    required this.ratingCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      padding: const EdgeInsets.only(left: 5, right: 7, top: 4, bottom: 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$rating',
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(width: 2),
          const Icon(Icons.star, color: Colors.yellow, size: 13),
          const SizedBox(width: 2),
          Text(
            '($ratingCount)',
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

