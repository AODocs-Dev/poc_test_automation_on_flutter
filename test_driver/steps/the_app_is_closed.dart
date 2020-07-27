import 'package:gherkin/gherkin.dart';

class TheAppIsClosed extends Given {
  TheAppIsClosed()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    print("=== TheAppIsClosed ===");
  }

  @override
  RegExp get pattern => RegExp(r"The app is closed");
}
