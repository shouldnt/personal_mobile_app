import 'dart:ui'; // ignore: file_names

import 'package:flutter/material.dart';

class ToolCard extends StatelessWidget {
  final String imgLink;
  final String title;
  final Function? onTap;
  const ToolCard({
    Key? key, 
    required this.imgLink,
    required this.title,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(onTap != null) onTap!();
      },
      child: Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 7.0,
            sigmaY: 7.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(35, 255, 255, 255)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imgLink,
                ),
                Container(height: 20),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color.fromARGB(100, 0, 0, 0),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}