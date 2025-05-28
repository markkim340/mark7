import 'package:flutter/material.dart';
import 'package:mark7/common/const/colors.dart';

class ProductCard extends StatelessWidget {
  final String id;

  const ProductCard({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'asset/img/misc/sample.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "떡뽂기",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "이것은 떡볶이입니다. 맛있어요!\n떡볶이 떡과 어묵이 들어가요.",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  "10000won",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
