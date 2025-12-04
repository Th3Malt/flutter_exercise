import '../../../app_imports.dart';

class ScrollablePage extends StatefulWidget {
  const ScrollablePage({super.key});

  @override
  State<ScrollablePage> createState() => ScrollablePageState();
}

class ScrollablePageState extends State<ScrollablePage>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();

  late final AnimationController animController;
  late final Animation<double> footerTranslateY;
  late final Animation<double> footerScale;
  late final Animation<double> footerOpacity;

  static const double footerHeight = 88.0;

  double get startShowOffset => MediaQuery.of(context).size.height * 0.01;
  double get endShowOffset => MediaQuery.of(context).size.height * 0.35;

  @override
  void initState() {
    super.initState();

    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    footerTranslateY = Tween<double>(begin: footerHeight + 32, end: 0).animate(
      CurvedAnimation(parent: animController, curve: Curves.easeOutCubic),
    );

    footerScale = Tween<double>(
      begin: 0.97,
      end: 1,
    ).animate(CurvedAnimation(parent: animController, curve: Curves.easeOut));

    footerOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: animController, curve: Curves.easeOut));

    scrollController.addListener(onScroll);
    animController.value = 0;
  }

  double lastOffset = 0;

  void onScroll() {
    final offset = scrollController.offset;
    final isScrollingDown = offset > lastOffset;

    double progress;

    if (isScrollingDown) {
      progress =
          ((offset - startShowOffset) / (endShowOffset - startShowOffset))
              .clamp(0.0, 1.0);
    } else {
      progress = (offset / endShowOffset).clamp(0.0, 1.0);
    }

    animController.value = progress;
    lastOffset = offset;
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.masterColorA,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "Here's your landing page:",
          style: TextStyle(fontSize: 20, color: AppColors.dark, height: 1.2),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: footerHeight + MediaQuery.viewPaddingOf(context).bottom,
              ),
              physics: const BouncingScrollPhysics(),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeaderCard(),
                  SizedBox(height: 16),
                  DescriptionText(),
                ],
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                ignoring: true,
                child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white,
                        Colors.white54,
                        Colors.white.withValues(alpha: 0),
                      ],
                      stops: const [0.0, 0.35, 1.0],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 16,
              right: 16,
              bottom: 12,
              child: SafeArea(
                child: AnimatedBuilder(
                  animation: animController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, footerTranslateY.value),
                      child: Transform.scale(
                        scale: footerScale.value,
                        child: Opacity(
                          opacity: footerOpacity.value,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: const FooterCard(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
