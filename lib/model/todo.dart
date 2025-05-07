import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class ToDo extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  ToDo({
    required this.title,
    required this.description,
  });
}
