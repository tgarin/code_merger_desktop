import 'dart:io';
import 'package:path/path.dart' as path;

class FileMerger {
  static final Map<String, String> supportedExtensions = {
    '.dart': 'Dart',
    '.js': 'JavaScript',
    '.py': 'Python',
    '.java': 'Java',
    '.cpp': 'C++',
    '.c': 'C',
    '.cs': 'C#',
    '.php': 'PHP',
    '.rb': 'Ruby',
    '.go': 'Go',
    '.rs': 'Rust',
    '.swift': 'Swift',
    '.kt': 'Kotlin',
    '.ts': 'TypeScript',
    '.scala': 'Scala',
    '.hs': 'Haskell',
    '.lua': 'Lua',
    '.pl': 'Perl',
    '.r': 'R',
    '.m': 'Objective-C',
    '.vb': 'Visual Basic',
    '.groovy': 'Groovy',
    '.sh': 'Shell Script',
    '.sql': 'SQL',
    '.html': 'HTML',
    '.css': 'CSS',
    '.xml': 'XML',
    '.json': 'JSON',
    '.yaml': 'YAML',
    '.md': 'Markdown',
  };

  static Future<String> mergeFilesInFolder(String folderPath) async {
    StringBuffer mergedCode = StringBuffer();
    Directory directory = Directory(folderPath);

    await for (FileSystemEntity entity in directory.list(recursive: true)) {
      if (entity is File) {
        String extension = path.extension(entity.path).toLowerCase();
        if (supportedExtensions.containsKey(extension)) {
          mergedCode.writeln('// File: ${entity.path}');
          mergedCode.writeln('// Language: ${supportedExtensions[extension]}');
          mergedCode.writeln(await entity.readAsString());
          mergedCode.writeln('\n// End of ${entity.path}\n');
        }
      }
    }

    return mergedCode.toString();
  }
}
