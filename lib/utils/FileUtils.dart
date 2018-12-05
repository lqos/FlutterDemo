import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtils {
  static getAppFile() async {
    if (Platform.isAndroid) {
      Directory sd = await getExternalStorageDirectory();
      Directory sw = await getApplicationDocumentsDirectory();
      Directory st = await getTemporaryDirectory();

      print("sd = " + sd.path);
      print("sw = " + sw.path);
      print("st = " + st.path);
//      Directory df = await Directory.systemTemp.createTemp("temp");
//      print("systemTemp ---> " + df.path);
//
//      var directory = await new Directory("dir${Platform.pathSeparator}one").create(recursive: true);
//
//      assert(await directory.exists() == true);
//      //输出绝对路径
//      print("Path: ${directory.absolute.path}");

    } else {}
  }

  static saveNewsDetailFile(String cssStr) async {
    Directory sw = await getApplicationDocumentsDirectory();
    Directory sf = await sw.createTemp("temp.html");
    File file = File(sw.path + "/news_temps.html");
    file.create();
    print("sf = " + sf.path);
    print("file = " + file.path);

    file = await file.writeAsString(cssStr);
    return file;
  }

  static saveByteFile(String byteData, String filePath) async {
    File file = File(filePath);
    file.create();

    print("file = " + file.path);

    file = await file.writeAsString(byteData);
    return file.path;
  }
}
