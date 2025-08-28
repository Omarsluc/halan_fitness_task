import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theming/colors.dart';

class WeeklyChart extends StatefulWidget {
  final Map<String, int> weeklyFrequency;

  const WeeklyChart({
    super.key,
    required this.weeklyFrequency,
  });

  @override
  State<WeeklyChart> createState() => _WeeklyChartState();
}

class _WeeklyChartState extends State<WeeklyChart>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    // Start animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final maxValue = widget.weeklyFrequency.values.isEmpty
        ? 1
        : widget.weeklyFrequency.values.reduce((a, b) => a > b ? a : b);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * _animation.value),
          child: Opacity(
            opacity: _animation.value,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorsManager.primaryColor.withOpacity(0.1),
                    ColorsManager.primaryColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ColorsManager.primaryColor.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.primaryColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.bar_chart,
                          color: ColorsManager.darkColor,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Weekly Activity',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  SizedBox(
                    height: 200.h,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: maxValue.toDouble(),
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            tooltipRoundedRadius: 8,
                            tooltipPadding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            tooltipMargin: 8,
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              final day = days[group.x];
                              final value = widget.weeklyFrequency[day] ?? 0;
                              return BarTooltipItem(
                                '$day: $value workouts',
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (value >= 0 && value < days.length) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 8.h),
                                    child: Text(
                                      days[value.toInt()],
                                      style: TextStyle(
                                        color: ColorsManager.greyColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                }
                                return const Text('');
                              },
                              reservedSize: 30,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: maxValue > 5
                                  ? (maxValue / 5).ceil().toDouble()
                                  : 1,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: TextStyle(
                                    color: ColorsManager.greyColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: days.asMap().entries.map((entry) {
                          final index = entry.key;
                          final day = entry.value;
                          final value = widget.weeklyFrequency[day] ?? 0;

                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: (value * _animation.value).toDouble(),
                                color: ColorsManager.primaryColor,
                                width: 20.w,
                                borderRadius: BorderRadius.circular(10),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: maxValue.toDouble(),
                                  color: ColorsManager.primaryColor
                                      .withOpacity(0.1),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        gridData: FlGridData(
                          show: true,
                          horizontalInterval: maxValue > 5
                              ? (maxValue / 5).ceil().toDouble()
                              : 1,
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color:
                                  ColorsManager.primaryColor.withOpacity(0.1),
                              strokeWidth: 1,
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Summary stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem(
                        'Total',
                        (widget.weeklyFrequency.values
                                    .fold(0, (sum, value) => sum + value) *
                                _animation.value)
                            .round()
                            .toString(),
                        Icons.fitness_center,
                      ),
                      _buildSummaryItem(
                        'Average',
                        widget.weeklyFrequency.values.isEmpty
                            ? '0'
                            : (widget.weeklyFrequency.values
                                        .fold(0, (sum, value) => sum + value) /
                                    widget.weeklyFrequency.values.length *
                                    _animation.value)
                                .round()
                                .toString(),
                        Icons.trending_up,
                      ),
                      _buildSummaryItem(
                        'Peak',
                        widget.weeklyFrequency.values.isEmpty
                            ? '0'
                            : (widget.weeklyFrequency.values
                                        .reduce((a, b) => a > b ? a : b) *
                                    _animation.value)
                                .round()
                                .toString(),
                        Icons.show_chart,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: ColorsManager.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: ColorsManager.primaryColor,
            size: 16.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: ColorsManager.greyColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
