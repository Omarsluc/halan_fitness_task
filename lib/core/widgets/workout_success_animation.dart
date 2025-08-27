import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';

class WorkoutSuccessAnimation extends StatefulWidget {
  final VoidCallback? onAnimationComplete;
  final String message;

  const WorkoutSuccessAnimation({
    super.key,
    this.onAnimationComplete,
    this.message = 'Workout Logged Successfully! 💪',
  });

  @override
  State<WorkoutSuccessAnimation> createState() => _WorkoutSuccessAnimationState();
}

class _WorkoutSuccessAnimationState extends State<WorkoutSuccessAnimation>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _confettiController;
  late AnimationController _fadeController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  final List<AnimationController> _confettiControllers = [];
  final List<Animation<double>> _confettiAnimations = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    // Main scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Rotation animation
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Confetti animation
    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Create animations
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Create confetti animations
    for (int i = 0; i < 20; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 1500 + (i * 100)),
        vsync: this,
      );

      final animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ));

      _confettiControllers.add(controller);
      _confettiAnimations.add(animation);
    }
  }

  void _startAnimationSequence() async {
    // Start fade in
    _fadeController.forward();

    // Start scale and rotation
    await Future.delayed(const Duration(milliseconds: 200));
    _scaleController.forward();
    _rotationController.forward();

    // Start confetti
    await Future.delayed(const Duration(milliseconds: 400));
    _confettiController.forward();
    for (final controller in _confettiControllers) {
      controller.forward();
    }

    // Wait for animation to complete
    await Future.delayed(const Duration(milliseconds: 2500));
    
    // Call completion callback
    widget.onAnimationComplete?.call();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _fadeController.dispose();
    _confettiController.dispose();
    for (final controller in _confettiControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black54,
        child: Stack(
          children: [
            // Confetti particles
            ...List.generate(20, (index) {
              return Positioned(
                left: (index * 20.0) % MediaQuery.of(context).size.width,
                top: -50.0,
                child: AnimatedBuilder(
                  animation: _confettiAnimations[index],
                  builder: (context, child) {
                    final progress = _confettiAnimations[index].value;
                    final yOffset = progress * (MediaQuery.of(context).size.height + 100);
                    final xOffset = progress * 100 * (index % 2 == 0 ? 1 : -1);
                    final rotation = progress * 720;
                    final scale = 0.5 + (progress * 0.5);

                    return Transform.translate(
                      offset: Offset(xOffset, yOffset),
                      child: Transform.rotate(
                        angle: rotation * 3.14159 / 180,
                        child: Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: _getConfettiColor(index),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),

            // Main success content
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: RotationTransition(
                  turns: _rotationAnimation,
                  child: Container(
                    padding: EdgeInsets.all(32.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorsManager.primaryColor,
                          ColorsManager.greenColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: ColorsManager.primaryColor.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Success icon
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            size: 60.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        
                        // Success message
                        Text(
                          widget.message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        SizedBox(height: 16.h),
                        
                        // Celebration emojis
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildCelebrationEmoji('🎉', 0),
                            _buildCelebrationEmoji('💪', 200),
                            _buildCelebrationEmoji('🔥', 400),
                            _buildCelebrationEmoji('⭐', 600),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCelebrationEmoji(String emoji, int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800 + delay),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Transform.rotate(
            angle: value * 0.5,
            child: Text(
              emoji,
              style: TextStyle(fontSize: 24.sp),
            ),
          ),
        );
      },
    );
  }

  Color _getConfettiColor(int index) {
    final colors = [
      ColorsManager.primaryColor,
      ColorsManager.secondaryColor,
      ColorsManager.greenColor,
      ColorsManager.yellowColor,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.blue,
    ];
    return colors[index % colors.length];
  }
}
