import 'package:formfun_flutter_test/app_imports.dart';

class ProgressControl extends StatelessWidget {
  final double progress;
  final bool isPlaying;

  final ValueChanged<double> onChanged;
  final VoidCallback onPlay;
  final VoidCallback onPause;

  const ProgressControl({
    super.key,
    required this.progress,
    required this.isPlaying,
    required this.onChanged,
    required this.onPlay,
    required this.onPause,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${(progress * 100).toInt()}%",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.activeCard,
          ),
        ),

        const SizedBox(height: 10),

        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6,
            activeTrackColor: AppColors.activeCard,
            inactiveTrackColor: Colors.grey[200],
            thumbColor: Colors.white,
          ),
          child: Slider(
            value: progress,
            min: 0.0,
            max: 1.0,
            onChanged: (value) => onChanged(value),
          ),
        ),
        IconButton(
          iconSize: 32,
          onPressed: () {
            if (progress == 1.0) {
              onPlay();
            } else {
              isPlaying ? onPause() : onPlay();
            }
          },
          icon: Icon(
            progress == 1.0
                ? Icons.play_arrow
                : (isPlaying ? Icons.pause : Icons.play_arrow),
            color: AppColors.activeCard,
          ),
        ),
      ],
    );
  }
}
