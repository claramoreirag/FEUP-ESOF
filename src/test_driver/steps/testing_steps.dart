import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class GivenInPage extends Given1WithWorld<String, FlutterWorld> {
  //GivenInPage()
      //: super(StepDefinitionConfiguration()..timeout = Duration(seconds: 10));
  @override
  Future<void> executeStep(String page) async {
    await Future.delayed(Duration(seconds: 10));
    bool isInPage =
        await FlutterDriverUtils.isPresent(world.driver, find.byValueKey(page));
    expectMatch(isInPage, true);
  }

  @override
  RegExp get pattern => RegExp(r"I am on the {string} page");
}
