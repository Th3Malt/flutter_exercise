import 'package:formfun_flutter_test/app_imports.dart';

class FileProgressCard extends StatelessWidget {
  final double progress;
  final bool isPlaying;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final AnimationController controller;
  final String timeLabel;

  const FileProgressCard({
    super.key,
    required this.progress,
    required this.controller,
    required this.isPlaying,
    required this.onPlay,
    required this.onPause,
    required this.timeLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          boxShadow: isPlaying
              ? [
                  BoxShadow(
                    color: AppColors.activeCard.withValues(alpha: .5),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.transparent,
                    blurRadius: 0,
                    spreadRadius: 0,
                  ),
                ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(32),
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: isPlaying ? onPause : onPlay,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/searching.json',
                          height: 80,
                          controller: controller,
                        ),
                        const SizedBox(height: 16),

                        Text(
                          'Loading File',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Text(
                          timeLabel,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.lightModeTagline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned.fill(
                  child: CustomPaint(
                    painter: AnimatedProgressBorderPainter(
                      progress: progress,
                      color: AppColors.activeCard,
                      strokeWidth: 2,
                      radius: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedProgressBorderPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final double radius;
  final bool glow;
  final double glowStrength;

  AnimatedProgressBorderPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.radius,
    this.glow = true,
    this.glowStrength = 0.6,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    path.moveTo(size.width / 2, 0);

    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(
      Offset(size.width - radius, size.height),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    path.lineTo(0, radius);
    path.arcToPoint(
      Offset(radius, 0),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    path.lineTo(size.width / 2, 0);

    final metric = path.computeMetrics().first;
    final totalLength = metric.length;
    final drawLength = totalLength * progress;

    final visiblePath = metric.extractPath(0, drawLength);

    if (glow && progress > 0) {
      final glowPaint = Paint()
        ..color = color.withValues(alpha: glowStrength)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
        ..strokeWidth = strokeWidth * 1.3
        ..style = PaintingStyle.stroke;

      canvas.drawPath(visiblePath, glowPaint);
    }

    canvas.drawPath(visiblePath, paint);
  }

  @override
  bool shouldRepaint(covariant AnimatedProgressBorderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.glowStrength != glowStrength;
  }
}
