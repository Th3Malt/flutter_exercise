import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/features/exercise1/pages/interactive_card_page.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: Exercise1)
Widget buildExercise1(BuildContext context) {
  return const InteractiveCardPage();
}

class Exercise1 extends StatelessWidget {
  const Exercise1({super.key});

  @override
  Widget build(BuildContext context) {
    return const InteractiveCardPage();
  }
}
