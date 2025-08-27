import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';

class ThemeSwitcher extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final double size;

  const ThemeSwitcher({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    this.size = 60,
  });

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Set initial animation state
    if (widget.isDarkMode) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleTheme() {
    if (widget.isDarkMode) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    widget.onThemeChanged(!widget.isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleTheme,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.size.w,
              height: widget.size.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isDarkMode
                      ? [
                          ColorsManager.darkColor,
                          ColorsManager.secondaryDarkColor,
                        ]
                      : [
                          ColorsManager.primaryColor,
                          ColorsManager.secondaryColor,
                        ],
                ),
                borderRadius: BorderRadius.circular(widget.size / 2),
                boxShadow: [
                  BoxShadow(
                    color: (widget.isDarkMode
                            ? ColorsManager.darkColor
                            : ColorsManager.primaryColor)
                        .withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Sun icon (light mode)
                  Positioned(
                    top: widget.size * 0.2,
                    left: widget.size * 0.2,
                    child: AnimatedOpacity(
                      opacity: widget.isDarkMode ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.wb_sunny,
                        color: Colors.white,
                        size: widget.size * 0.3,
                      ),
                    ),
                  ),

                  // Moon icon (dark mode)
                  Positioned(
                    top: widget.size * 0.2,
                    right: widget.size * 0.2,
                    child: AnimatedOpacity(
                      opacity: widget.isDarkMode ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.nightlight_round,
                        color: Colors.white,
                        size: widget.size * 0.3,
                      ),
                    ),
                  ),

                  // Toggle indicator
                  Positioned(
                    top: widget.size * 0.1,
                    left: widget.size * 0.1,
                    right: widget.size * 0.1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),

                  // Center icon
                  Center(
                    child: Transform.rotate(
                      angle: _rotationAnimation.value * 3.14159,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          key: ValueKey(widget.isDarkMode),
                          color: Colors.white,
                          size: widget.size * 0.25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedThemeSwitcher extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final double size;

  const AnimatedThemeSwitcher({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    this.size = 60,
  });

  @override
  State<AnimatedThemeSwitcher> createState() => _AnimatedThemeSwitcherState();
}

class _AnimatedThemeSwitcherState extends State<AnimatedThemeSwitcher>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _onThemeChanged(bool isDarkMode) {
    _bounceController.forward().then((_) {
      _bounceController.reverse();
    });
    widget.onThemeChanged(isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _bounceAnimation.value,
          child: ThemeSwitcher(
            isDarkMode: widget.isDarkMode,
            onThemeChanged: _onThemeChanged,
            size: widget.size,
          ),
        );
      },
    );
  }
}
