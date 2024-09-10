import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FilePickerService {
  static Future<File?> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null;
  }
}
