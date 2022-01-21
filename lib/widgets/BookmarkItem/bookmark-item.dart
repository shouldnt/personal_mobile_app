import 'dart:ui'; // ignore: file_names

import 'package:flutter/material.dart';
import 'package:personal_tools/DB/boxs/bookmark/bookmark.dart';
import 'package:remixicon/remixicon.dart';

class BookmarkItem extends StatelessWidget {
  final Function? onTap;
  final Bookmark bookmark;
  const BookmarkItem({
    Key? key, 
    required this.bookmark,
    this.onTap,
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
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(35, 255, 255, 255)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/bookmark-tool.png",
                ),
                Container(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookmark.name,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: List.generate(5, (index) {
                                return Container(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: index + 1 <= bookmark.rating 
                                      ? const Icon(Remix.star_fill,
                                          size: 13, color: Color(0xffFAA51C))
                                      : const Icon(Remix.star_fill,
                                          size: 13, color: Color(0x55747474)),
                                  );
                                }
                              )
                            )
                          ),
                          Text("${bookmark.bookmark}/${bookmark.end}", style: const TextStyle(color: Color(0xaaffffff), fontSize: 12),),
                        ],
                      ),
                      
                    ],
                  ),
                )
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