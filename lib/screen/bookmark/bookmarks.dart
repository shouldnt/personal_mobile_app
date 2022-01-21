import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_tools/DB/constants.dart';
import 'package:personal_tools/DB/boxs/bookmark/bookmark.dart';
import 'package:personal_tools/DB/local_db.dart';
import 'package:personal_tools/widgets/BookmarkDetailPopup/bookmark-detail-popup.dart';
import 'package:personal_tools/widgets/BookmarkItem/bookmark-item.dart';
import 'package:remixicon/remixicon.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  bool dbLoading = true;
  Box<Bookmark>? box;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    loadHiveBox();
    super.initState();
  }

  loadHiveBox() async {
    box = await HiveDB.openBox(bookmarkBox, version: bookmarkBoxVersion);
    setState(() {
      dbLoading = false;
    });
  }

  mockAddData() {
    Bookmark bookmark = Bookmark(
        name: 'testname', createdAt: DateTime.now(), updatedAt: DateTime.now());
    box!.add(bookmark);
  }

  mainscreen() => GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Remix.arrow_left_s_line,
                  size: 30, color: Color(0xff9A9A9A)),
            ),
            // title: TextField(
            //   controller: searchController,
            //   autofocus: true,
            //   keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
            //   onEditingComplete: () {
            //   },
            //   onSubmitted: (value) {
            //   },
            //   style: const TextStyle(color: Colors.white),
            //   decoration: const InputDecoration(
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Color(0x44ffffff), width: 1),
            //       borderRadius: BorderRadius.all(Radius.circular(15))
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Color(0x44ffffff), width: 1),
            //       borderRadius: BorderRadius.all(Radius.circular(25))
            //     ),
            //     contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            //   ),
            // ),
            actions: [
              GestureDetector(
                onTap: () {

                  showDialog(context: context, builder: (context) {
                    return BookmarkDetailPopup(
                      isCreate: true,
                      create: (Bookmark bookmark) {
                        box!.add(bookmark);
                      },
                      bookmark: Bookmark(
                        name: '', 
                        createdAt: DateTime.now(), 
                        updatedAt: DateTime.now()
                      )
                    );
                  });
                },
                child: const Icon(Remix.add_line, size: 30, color: Color(0xff9A9A9A)),
              ),
              Container(width: 20)
            ],
          ),
          body: Container(
              padding: const EdgeInsets.all(20),
              child: ValueListenableBuilder(
                valueListenable: box!.listenable(),
                builder: (BuildContext context, Box<Bookmark> bookmarkBox,
                    Widget? child) {
                  List<Bookmark> bookmarks = bookmarkBox.values.toList();
                  bookmarks.sort((bookmark1, bookmark2) =>
                      bookmark2.updatedAt.compareTo(bookmark1.updatedAt));
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      Bookmark bookmark = bookmarks[index];
                      return Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: BookmarkItem(
                          bookmark: bookmark,
                          onTap: () => {
                            BookmarkDetailPopup.showBookmarkDetailPopup(context, bookmark)
                          },
                        ),
                      );
                    },
                    itemCount: bookmarkBox.length,
                  );
                },
              )),
        ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/bookmark-tool-bg.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        dbLoading ? const Text('loading') : mainscreen()
      ],
    );
  }

  @override
  void dispose() {
    box!.close();
    super.dispose();
  }
}
