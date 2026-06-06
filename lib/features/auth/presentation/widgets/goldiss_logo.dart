import 'package:flutter/material.dart';
import 'package:goldiss_chat/Core/app_theme.dart';

class GoldissLogo extends StatelessWidget {
  final double size;
  final bool showNotification;

  const GoldissLogo({super.key, this.size = 80, this.showNotification = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Chat bubble body
          Positioned(
            bottom: 0,
            left: 0,
            right: size * 0.1,
            top: size * 0.1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size * 0.2),
                  topRight: Radius.circular(size * 0.2),
                  bottomRight: Radius.circular(size * 0.2),
                  bottomLeft: Radius.circular(size * 0.05),
                ),
              ),
              child: Center(child: _SparkleIcon(size: size * 0.4)),
            ),
          ),
          // Notification dot
          if (showNotification)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: size * 0.22,
                height: size * 0.22,
                decoration: const BoxDecoration(
                  color: AppColors.pink,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SparkleIcon extends StatelessWidget {
  final double size;
  const _SparkleIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: _SparklePainter());
  }
}

class _SparklePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    final path = Path();
    // 4-pointed star (sparkle)
    path.moveTo(cx, cy - r);
    path.quadraticBezierTo(cx + r * 0.15, cy - r * 0.15, cx + r, cy);
    path.quadraticBezierTo(cx + r * 0.15, cy + r * 0.15, cx, cy + r);
    path.quadraticBezierTo(cx - r * 0.15, cy + r * 0.15, cx - r, cy);
    path.quadraticBezierTo(cx - r * 0.15, cy - r * 0.15, cx, cy - r);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Small logo with squircle container for onboarding
class GoldissLogoSmall extends StatelessWidget {
  final double size;
  const GoldissLogoSmall({super.key, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7B5FE0), Color(0xFF5E39E0)],
        ),
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(child: _SparkleIcon(size: size * 0.52)),
    );
  }
}
