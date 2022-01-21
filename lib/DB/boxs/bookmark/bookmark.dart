import 'package:hive/hive.dart';
import 'package:personal_tools/DB/constants.dart';

part 'bookmark.g.dart';

@HiveType(typeId: bookmarkTypeId)
class Bookmark extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int bookmark;

  @HiveField(2)
  int end;

  @HiveField(3)
  int readTimes;

  @HiveField(4)
  bool isFavourite;

  @HiveField(5)
  int rating;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime updatedAt;

  Bookmark({
    required this.name,
    this.bookmark = 0,
    this.end = 0,
    this.isFavourite = false,
    this.rating = 0,
    this.readTimes = 0,
    required this.createdAt,
    required this.updatedAt,
  });
}
