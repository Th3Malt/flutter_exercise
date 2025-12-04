import 'package:flutter/material.dart';
import 'package:formfun_flutter_test/features/exercise2/pages/scrollable_page.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: Exercise2)
Widget buildExercise2(BuildContext context) {
  return const Exercise2();
}

class Exercise2 extends StatelessWidget {
  const Exercise2({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScrollablePage();
  }
}
