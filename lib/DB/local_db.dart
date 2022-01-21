import 'package:hive_flutter/hive_flutter.dart';
import 'package:personal_tools/DB/boxs/bookmark/bookmark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveDB {
  static final Map<String, dynamic> _boxs = {};
  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Bookmark>(BookmarkAdapter());
  }
  static Future<Box<T>> openBox<T>(boxName, {int? version}) async {
    if(HiveDB._boxs[boxName] != null && HiveDB._boxs[boxName]!.isOpen) {
      return HiveDB._boxs[boxName] as Box<T>;
    }
    Box<T> box = await Hive.openBox<T>(boxName);
    HiveDB._boxs[boxName] = box;

    if(version == null) return box;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentVersion = prefs.getInt(boxName) ?? 0;

    if(version != currentVersion) {
      box.clear();
      prefs.setInt(boxName, version);
    }

    return box;
  }
}