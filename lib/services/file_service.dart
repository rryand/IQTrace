import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileService { // TODO: Remove File Service
  static const USER_FILE_NAME = 'user.json';

  Future<String> get appDocsPath async {
    Directory appDocsDir = await getApplicationDocumentsDirectory();
    return appDocsDir.path;
  }

  Future<String> moveToAppDocs(File sourceFile, [String? newName]) async {
    print('moving cache...');
    final String fullFileName = sourceFile.path.split('/').last;
    final String suffix = fullFileName.split('.').last;

    String targetPath = '${await appDocsPath}/'
        '${newName ?? fullFileName.split('.').first}.$suffix';

    try {
      await sourceFile.copy(targetPath);
      await sourceFile.delete();
      return targetPath;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
  

  Future<File> saveUser(Map<String, dynamic> user) async {
    print('saving user info locally');
    File userFile = File('${await appDocsPath}/$USER_FILE_NAME');

    try {
      return await userFile.writeAsString(user.toString());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}