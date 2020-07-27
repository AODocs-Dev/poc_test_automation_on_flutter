import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ICanSeeMoviesInTheList extends Then1<int> {
  ICanSeeMoviesInTheList()
      : super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));

  @override
  Future<void> executeStep(int count) async {
    print("=== ICanSeeMoviesInTheList ===");

    expectMatch("4", count);

  }

  @override
  RegExp get pattern => RegExp(r"I can see more than {int} movie(s) in the list");
}
