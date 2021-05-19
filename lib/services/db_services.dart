import 'package:assignment_app/models/note.dart';
import 'package:hive/hive.dart';

class DBService {
  Future<void> addNote(String content) async {
    var notesBox = await Hive.openBox('notes');

    var note = Note()
      ..note = content
      ..time = DateTime.now().millisecondsSinceEpoch;
    await notesBox.add(note.toJson());
  }
}