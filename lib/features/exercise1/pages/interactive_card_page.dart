import 'package:formfun_flutter_test/app_imports.dart';

class InteractiveCardPage extends StatefulWidget {
  const InteractiveCardPage({super.key});

  @override
  State<InteractiveCardPage> createState() => _InteractiveCardPageState();
}

class _InteractiveCardPageState extends State<InteractiveCardPage>
    with TickerProviderStateMixin {
  double _progress = 0.0;
  bool _isPlaying = false;

  late final _progressController = AnimationController(
    duration: const Duration(minutes: 1),
    vsync: this,
  );

  late final _lottieController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  @override
  void initState() {
    super.initState();

    _progressController.addListener(() {
      setState(() {
        _progress = _progressController.value;
      });

      if (_progressController.isCompleted) {
        pause();
      }
    });
  }

  void play() {
    if (_progress >= 1.0) {
      _progressController.value = 0.0;
    }

    _lottieController.repeat();
    _progressController.forward(from: _progress);

    setState(() {
      _isPlaying = true;
    });
  }

  void pause() {
    _lottieController.stop();
    _progressController.stop();

    setState(() {
      _isPlaying = false;
    });
  }

  void seek(double value) {
    pause();
    _progressController.value = value;
  }

  String get timeRemaining {
    final totalSeconds = _progressController.duration!.inSeconds;
    final currentSeconds = (totalSeconds * (1 - _progress)).round();

    final minutes = currentSeconds ~/ 60;
    final seconds = currentSeconds % 60;

    return "${minutes}m ${seconds.toString().padLeft(2, '0')}s";
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEBE8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FileProgressCard(
              onPlay: play,
              onPause: pause,
              controller: _lottieController,
              progress: _progress,
              isPlaying: _isPlaying,
              timeLabel: timeRemaining,
            ),

            const SizedBox(height: 80),

            ProgressControl(
              progress: _progress,
              isPlaying: _isPlaying,
              onChanged: seek,
              onPlay: play,
              onPause: pause,
            ),
          ],
        ),
      ),
    );
  }
}
