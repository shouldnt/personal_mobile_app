import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class Rating extends StatelessWidget {
  final Function(double) onChange;
  final double value;
  const Rating({Key? key, required this.onChange, this.value = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: index + 1 <= value 
              ? const Icon(Remix.star_fill, size: 25, color: Color(0xffFAA51C))
              : const Icon(Remix.star_fill, size: 25, color: Color(0x55747474))
            );
          }),
        ),
        Slider(
          value: value,
          max: 5,
          divisions: 5,
          thumbColor: const Color(0xffFAA51C),
          activeColor: const Color(0xffFAA51C),
          onChanged: (double value) {
            onChange(value);
          },
        )
      ],
    );
  }

}