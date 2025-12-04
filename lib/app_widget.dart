import 'package:formfun_flutter_test/app_imports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScrollablePage(),
      theme: ThemeData(fontFamily: FontFamily.AktivGrotesk.name),
    );
  }
}
