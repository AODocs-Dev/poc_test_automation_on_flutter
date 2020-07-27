import 'package:gherkin/gherkin.dart';

class IOpenTheApp extends Given {
  IOpenTheApp()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep() async {
    print("=== IOpenTheApp ===");
  }

  @override
  RegExp get pattern => RegExp(r"I open the app");
}
