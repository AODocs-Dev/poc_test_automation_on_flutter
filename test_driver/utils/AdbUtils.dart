import 'dart:io';

class AdbUtils {
  Future pressBack() async {
    await Process.run(
      'adb',
      <String>['shell', 'input', 'keyevent', 'KEYCODE_BACK'],
      runInShell: true,
    );
  }
}