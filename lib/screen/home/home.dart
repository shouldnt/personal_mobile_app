
import 'package:flutter/material.dart';
import 'package:personal_tools/screen/bookmark/bookmarks.dart';
import 'package:remixicon/remixicon.dart';
import 'package:personal_tools/widgets/ToolCard/tool-card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Stack(
      children: [
        Image.asset(
          "assets/images/main-screen-bg.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            leading: const Icon(Remix.menu_2_line, size: 30, color: Color(0xff9A9A9A)),
            actions: const [
              Icon(Remix.search_line, size: 30, color: Color(0xff9A9A9A))
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              // Generate 100 widgets that display their index in the List.
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: List.generate(1, (index) {
                return ToolCard(
                  key: Key(index.toString()),
                  imgLink: 'assets/images/bookmark-tool.png', 
                  title: 'bookmark tool',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BookmarksScreen()),
                    );
                  },
                );
              }),
            ),
          ),
        )
      ],
    );
  }
}