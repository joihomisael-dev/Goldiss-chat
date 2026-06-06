import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:goldiss_chat/Core/app_theme.dart';
import '../widgets/goldiss_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textOpacity;
  late Animation<double> _bottomOpacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _logoScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );
    _textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );
    _bottomOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.65, 0.9, curve: Curves.easeIn),
      ),
    );

    _ctrl.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/onboarding');
        }
      });
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7B5FE0),
                  Color(0xFF9B6FD0),
                  Color(0xFFD08060),
                  Color(0xFFF0A050),
                ],
                stops: [0.0, 0.35, 0.7, 1.0],
              ),
            ),
          ),
          // Floating particles
          const _Particles(),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              // Logo
              AnimatedBuilder(
                animation: _ctrl,
                builder: (context, child) => Opacity(
                  opacity: _logoOpacity.value,
                  child: Transform.scale(
                    scale: _logoScale.value,
                    child: const GoldissLogo(size: 110),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // App name
              AnimatedBuilder(
                animation: _ctrl,
                builder: (context, _) => Opacity(
                  opacity: _textOpacity.value,
                  child: Column(
                    children: [
                      const Text(
                        'Goldiss',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'CONNECT BEYOND THE HORIZON',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.75),
                          letterSpacing: 2.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 3),
              // Bottom loading
              AnimatedBuilder(
                animation: _ctrl,
                builder: (context, _) => Opacity(
                  opacity: _bottomOpacity.value,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 52),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 1.5,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'INITIALIZING VIRTUAL WORLD',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(0.6),
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Particles extends StatefulWidget {
  const _Particles();

  @override
  State<_Particles> createState() => _ParticlesState();
}

class _ParticlesState extends State<_Particles>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) =>
          CustomPaint(painter: _ParticlePainter(_ctrl.value)),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final double t;
  _ParticlePainter(this.t);

  static final List<Offset> _positions = [
    const Offset(0.2, 0.15),
    const Offset(0.75, 0.28),
    const Offset(0.55, 0.65),
    const Offset(0.15, 0.7),
    const Offset(0.85, 0.55),
    const Offset(0.4, 0.82),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < _positions.length; i++) {
      final phase = (t + i * 0.17) % 1.0;
      final opacity = (math.sin(phase * math.pi * 2) * 0.5 + 0.5) * 0.6;
      final paint = Paint()
        ..color = Colors.white.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(_positions[i].dx * size.width, _positions[i].dy * size.height),
        3.5,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => old.t != t;
}
