import 'package:flutter_driver/flutter_driver.dart';

class WaitUtils {
  Future<bool> isPresent(SerializableFinder finder, FlutterDriver driver,
      {Duration timeout = const Duration(seconds: 0)}) async {
    try {
      await driver.waitFor(finder, timeout: timeout);
      return true;
    } catch (e) {
      return false;
    }
  }
}
