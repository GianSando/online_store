import 'package:hive/hive.dart';

class LocalStarage {
  static late Box<dynamic> box;

  static Future<void> init() async {
    box = await Hive.openBox('myBox');
  }
}
