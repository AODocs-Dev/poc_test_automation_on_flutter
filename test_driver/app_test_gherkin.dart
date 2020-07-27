import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/the_app_is_closed.dart';
import 'steps/i_open_the_app.dart';
import 'steps/i_can_see_movies_in_list.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [
      StdoutReporter(),
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json')
    ]
  //..hooks = [HookExample(), AttachScreenshotOnFailedStepHook()]
    ..hooks = [AttachScreenshotOnFailedStepHook()]
  //..stepDefinitions = [TapButtonNTimesStep(), GivenIPickAColour()]
    ..stepDefinitions = [IOpenTheApp(), TheAppIsClosed()]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart"
    ..exitAfterTestRun = true; // set to false if debugging to exit cleanly
  return GherkinRunner().execute(config);
}
