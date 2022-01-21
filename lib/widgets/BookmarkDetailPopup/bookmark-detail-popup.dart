import 'dart:ffi';
import 'dart:ui'; // ignore: file_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:personal_tools/DB/boxs/bookmark/bookmark.dart';
import 'package:personal_tools/widgets/BookmarkDetailPopup/name-input.dart';
import 'package:personal_tools/widgets/BookmarkDetailPopup/number-input.dart';
import 'package:personal_tools/widgets/BookmarkDetailPopup/rating.dart';
import 'package:remixicon/remixicon.dart'; // ignore: file_names

// ignore: must_be_immutable
class BookmarkDetailPopup extends StatefulWidget {

  late Bookmark bookmark;
  late bool isCreate;
  late Function(Bookmark)? create;

  BookmarkDetailPopup({
    Key? key, 
    required this.bookmark,
    this.isCreate = false,
    this.create
  }) : super(key: key) {
    if(isCreate && create == null) {
      throw 'create must be provided when isCreate = true';
    }
  }

  @override
  State<BookmarkDetailPopup> createState() => _BookmarkDetailPopupState();

  static showBookmarkDetailPopup(context, Bookmark bookmark) {
    showDialog(context: context, builder: (context) {
      return BookmarkDetailPopup(bookmark: bookmark);
    });
  }

}

class _BookmarkDetailPopupState extends State<BookmarkDetailPopup> {

  TextEditingController nameController = TextEditingController();
  TextEditingController bookmarkController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController readTimesController = TextEditingController();
  bool isFavourite = false;
  int rating = 0;

  String nameDefault = '';
  int bookmarkDefault = 0;
  int endDefault = 0;
  int readTimesDefault = 0;
  bool isFavouriteDefault = false;
  int ratingDefault = 0;

  bool showCancelEditConfirmWidget = false;

  @override
  void initState() {
    setState(() {
      nameController.text= widget.bookmark.name;
      bookmarkController.text= widget.bookmark.bookmark.toString();
      endController.text = widget.bookmark.end.toString();
      readTimesController.text = widget.bookmark.readTimes.toString();
      isFavourite = widget.bookmark.isFavourite;
      rating = widget.bookmark.rating;

      nameDefault = widget.bookmark.name;
      bookmarkDefault = widget.bookmark.bookmark;
      endDefault = widget.bookmark.end;
      readTimesDefault = widget.bookmark.readTimes;
      isFavouriteDefault = widget.bookmark.isFavourite;
      ratingDefault = widget.bookmark.rating;
    });
    super.initState();
  }

  goback(BuildContext context) {
    Navigator.of(context).pop();
  }
  controllerTextToNumber(TextEditingController controller) {
    return int.tryParse(controller.text) ?? -1;
  }

  cancelEdit(context) {
    if(
      nameController.text.trim() != nameDefault ||
      controllerTextToNumber(bookmarkController) != bookmarkDefault ||
      controllerTextToNumber(endController) != endDefault ||
      controllerTextToNumber(readTimesController) != readTimesDefault ||
      isFavourite != isFavouriteDefault ||
      rating != ratingDefault
    ) {
      setState(() {
        showCancelEditConfirmWidget = true;
      });
    } else {
      goback(context);
    }
  }

  save(context) {
    widget.bookmark.name = nameController.text.trim();
    widget.bookmark.bookmark = controllerTextToNumber(bookmarkController);
    widget.bookmark.end = controllerTextToNumber(endController);
    widget.bookmark.readTimes = controllerTextToNumber(readTimesController);
    widget.bookmark.isFavourite = isFavourite;
    widget.bookmark.rating = rating.toInt();
    widget.bookmark.updatedAt = DateTime.now();
    if(widget.isCreate) {
      widget.bookmark.createdAt = DateTime.now();
      widget.create!(widget.bookmark);
    } else {
      widget.bookmark.save();
    }
    goback(context);
  }

  Widget confirmCancelEditWidget(BuildContext context) {
    Widget container(child) => Container(
      child: Center(child: child,),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      decoration: BoxDecoration(
        color: const Color(0xdd2a2a2a),
        border: Border.all(color: const Color.fromARGB(35, 255, 255, 255)),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: GestureDetector(
                onTap: () {
                  goback(context);
                },
                child: container(const Text(
                  'Go back',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text('changed not save!', style: TextStyle(color: Colors.white, fontSize: 12),),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                showCancelEditConfirmWidget = false;
              });
            },
            child: container(const Text(
              'Keep editing',
              style: TextStyle(color: Colors.white, fontSize: 12),
            )),
          ),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 7.0,
            sigmaY: 7.0,
          ),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.3),
            padding: const EdgeInsets.all(30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xdd2a2a2a),
                        border: Border.all(color: const Color.fromARGB(35, 255, 255, 255)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/bookmark-tool.png'
                              ),
                              Container(width: 10),
                              Expanded(
                                child: NameInput(controller: nameController, isCreate: widget.isCreate),
                              )
                            ],
                          ),
                          Container(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xdd2a2a2a),
                                    border: Border.all(color: const Color.fromARGB(35, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Bookmark', style: TextStyle(color: Colors.white)),
                                      Expanded(
                                        child: NumberInput(
                                          controller: bookmarkController,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(width: 10),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xdd2a2a2a),
                                    border: Border.all(color: const Color.fromARGB(35, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Total pages', style: TextStyle(color: Colors.white)),
                                      Expanded(
                                        child: NumberInput(
                                          controller: endController,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xdd2a2a2a),
                                    border: Border.all(color: const Color.fromARGB(35, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      const Text('Read times', style: TextStyle(color: Colors.white)),
                                      Expanded(
                                        child: NumberInput(
                                          controller: readTimesController,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(width: 10),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xdd2a2a2a),
                                    border: Border.all(color: const Color.fromARGB(35, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Favourite', style: TextStyle(color: Colors.white)),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isFavourite = !isFavourite;
                                          });
                                        },
                                        child: !isFavourite
                                          ? const Icon(Remix.heart_line, size: 15, color: Colors.grey) 
                                          : const Icon(Remix.heart_fill, size: 15, color: Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(height: 20),
                          Rating(
                            onChange: (value) {
                              setState(() {
                                rating = value.toInt();
                              });
                            },
                            value: rating + 0.0,
                          ),
                        ],
                      ),
                    ),
                    Container(height: 10),
                    showCancelEditConfirmWidget ? confirmCancelEditWidget(context)
                    : Row(
                      children: [
                        GestureDetector(
                          onTap: () => cancelEdit(context),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: const Color(0xdd2a2a2a),
                                border: Border.all(
                                  color: const Color.fromARGB(35, 255, 255, 255)),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Icon(Remix.close_line,
                                  size: 20, color: Colors.red),
                            ),
                          )
                        ),
                        Container(width: 10),
                        GestureDetector(
                            onTap: () => save(context),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: const Color(0xdd2a2a2a),
                                  border: Border.all(
                                    color: const Color.fromARGB(35, 255, 255, 255)),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Icon(Remix.check_line,
                                    size: 20, color: Colors.green),
                              ),
                            ))
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
