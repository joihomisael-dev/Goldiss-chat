import 'package:flutter/material.dart';
import 'package:goldiss_chat/Core/app_theme.dart';
import '../widgets/goldiss_logo.dart';
import '../widgets/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = const [
    _OnboardingData(
      title: 'Your Digital Universe',
      subtitle:
          'Connect with friends in a vibrant space\ninspired by anime culture.',
      gradientColors: [
        Color(0xFF4A2FA0),
        Color(0xFF7B5FE0),
        Color(0xFFD06090),
        Color(0xFFFF9060),
      ],
      illustrationTag: 'universe',
    ),
    _OnboardingData(
      title: 'Instant Anime-Style Chat',
      subtitle:
          'Express yourself with manga stickers,\nkinetic reactions & neon bubbles.',
      gradientColors: [
        Color(0xFF2B1F7A),
        Color(0xFF6040C0),
        Color(0xFF9060A0),
        Color(0xFFD07060),
      ],
      illustrationTag: 'chat',
    ),
    _OnboardingData(
      title: 'Your Sanctuary Awaits',
      subtitle:
          'Join a community of creators living\nat the edge of digital imagination.',
      gradientColors: [
        Color(0xFF1A1060),
        Color(0xFF5030A0),
        Color(0xFFA05090),
        Color(0xFFE08050),
      ],
      illustrationTag: 'sanctuary',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: _pages.length,
            itemBuilder: (context, index) =>
                _OnboardingPage(data: _pages[index], size: size),
          ),
          // Overlay bottom content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomContent(
              data: _pages[_currentPage],
              currentPage: _currentPage,
              totalPages: _pages.length,
              onNext: _nextPage,
              onSkip: () => Navigator.pushReplacementNamed(context, '/login'),
            ),
          ),
          // Top bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    GoldissLogoSmall(size: 36),
                    const SizedBox(width: 10),
                    const Text(
                      'Goldiss',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingData {
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final String illustrationTag;

  const _OnboardingData({
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.illustrationTag,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingData data;
  final Size size;

  const _OnboardingPage({required this.data, required this.size});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Gradient background (top 60%)
        Column(
          children: [
            SizedBox(
              height: size.height * 0.6,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: data.gradientColors,
                    stops: const [0.0, 0.35, 0.7, 1.0],
                  ),
                ),
                child: _IllustrationArea(tag: data.illustrationTag),
              ),
            ),
            Expanded(child: Container(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}

class _IllustrationArea extends StatelessWidget {
  final String tag;
  const _IllustrationArea({required this.tag});

  @override
  Widget build(BuildContext context) {
    switch (tag) {
      case 'universe':
        return const _UniverseIllustration();
      case 'chat':
        return const _ChatIllustration();
      case 'sanctuary':
        return const _SanctuaryIllustration();
      default:
        return const SizedBox();
    }
  }
}

// ---------- Illustration 1: Universe (two anime characters on rooftop) ----------
class _UniverseIllustration extends StatelessWidget {
  const _UniverseIllustration();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Speed lines
        CustomPaint(painter: _SpeedLinesPainter()),
        // City silhouette
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: CustomPaint(
            size: const Size(double.infinity, 120),
            painter: _CitySilhouettePainter(),
          ),
        ),
        // Characters placeholder (stylized)
        Positioned(bottom: 50, left: 30, child: _AnimeCharacter(isLeft: true)),
        Positioned(
          bottom: 50,
          right: 30,
          child: _AnimeCharacter(isLeft: false),
        ),
        // Badge
        Positioned(bottom: 20, right: 16, child: _NewArrivalsBadge()),
      ],
    );
  }
}

class _SpeedLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 6; i++) {
      final y = size.height * 0.1 + i * size.height * 0.08;
      canvas.drawLine(
        Offset(size.width * 0.3, y),
        Offset(size.width * 0.9, y - 20),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _CitySilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);

    final buildings = [
      [0.0, 0.9],
      [0.05, 0.5],
      [0.1, 0.9],
      [0.12, 0.6],
      [0.18, 0.3],
      [0.22, 0.6],
      [0.25, 0.7],
      [0.3, 0.2],
      [0.35, 0.5],
      [0.38, 0.8],
      [0.42, 0.35],
      [0.48, 0.65],
      [0.52, 0.4],
      [0.58, 0.7],
      [0.62, 0.25],
      [0.68, 0.55],
      [0.72, 0.75],
      [0.78, 0.3],
      [0.84, 0.6],
      [0.88, 0.45],
      [0.94, 0.7],
      [1.0, 0.9],
      [1.0, 1.0],
    ];

    for (final b in buildings) {
      path.lineTo(b[0] * size.width, b[1] * size.height);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _AnimeCharacter extends StatelessWidget {
  final bool isLeft;
  const _AnimeCharacter({required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: isLeft ? 1 : -1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Head
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isLeft ? const Color(0xFFFFB3C6) : const Color(0xFF90CAF9),
              shape: BoxShape.circle,
            ),
          ),
          // Body
          Container(
            width: 40,
            height: 70,
            decoration: BoxDecoration(
              color: isLeft
                  ? const Color(0xFFCE93D8).withOpacity(0.9)
                  : const Color(0xFF7986CB).withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewArrivalsBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: AppColors.primary, size: 14),
          const SizedBox(width: 6),
          const Text(
            'NEW ARRIVALS',
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Illustration 2: Chat ----------
class _ChatIllustration extends StatelessWidget {
  const _ChatIllustration();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(painter: _SpeedLinesPainter()),
        // Chat bubbles
        Positioned(
          top: 90,
          left: 24,
          child: _ChatBubble(
            text: 'Yo! Did you see the new arc? 🔥',
            isOutgoing: false,
          ),
        ),
        Positioned(
          top: 160,
          right: 24,
          child: _ChatBubble(text: 'It\'s insane!! ✨✨', isOutgoing: true),
        ),
        Positioned(
          top: 230,
          left: 24,
          child: _ChatBubble(
            text: 'Can\'t wait for next ep 👀',
            isOutgoing: false,
          ),
        ),
        Positioned(
          top: 300,
          right: 24,
          child: _ChatBubble(text: 'Same!! 💜', isOutgoing: true),
        ),
        // Floating emoji reactions
        Positioned(
          top: 80,
          right: 40,
          child: _FloatingEmoji(emoji: '⚡', angle: -0.3),
        ),
        Positioned(
          bottom: 80,
          left: 50,
          child: _FloatingEmoji(emoji: '✨', angle: 0.2),
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isOutgoing;
  const _ChatBubble({required this.text, required this.isOutgoing});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 220),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: isOutgoing
            ? const LinearGradient(colors: AppColors.primaryGradient)
            : null,
        color: isOutgoing ? null : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: Radius.circular(isOutgoing ? 20 : 4),
          bottomRight: Radius.circular(isOutgoing ? 4 : 20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 14,
          color: Colors.white.withOpacity(isOutgoing ? 1.0 : 0.92),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _FloatingEmoji extends StatelessWidget {
  final String emoji;
  final double angle;
  const _FloatingEmoji({required this.emoji, required this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22))),
      ),
    );
  }
}

// ---------- Illustration 3: Sanctuary ----------
class _SanctuaryIllustration extends StatelessWidget {
  const _SanctuaryIllustration();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(painter: _SpeedLinesPainter()),
        // Central glowing orb
        Center(
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withOpacity(0.35),
                  AppColors.primaryContainer.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.25),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.6),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                ),
                child: const Center(
                  child: Text('🌐', style: TextStyle(fontSize: 36)),
                ),
              ),
            ),
          ),
        ),
        // Orbiting user avatars
        ..._buildOrbitingAvatars(),
        // Stats badge
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: Colors.white.withOpacity(0.9),
                    size: 15,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Live community stats: +1.2k today',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildOrbitingAvatars() {
    final avatars = ['🧑', '👩', '🧒', '👦', '👧', '🧑'];
    final colors = [
      const Color(0xFFAB8FFE),
      const Color(0xFFFF80AB),
      const Color(0xFF80DEEA),
      const Color(0xFFFFCC80),
      const Color(0xFFA5D6A7),
      const Color(0xFFEF9A9A),
    ];
    const radius = 100.0;
    const cx = 0.5;
    const cy = 0.45;
    const pi = 3.14159265;

    return List.generate(avatars.length, (i) {
      final angle = (i / avatars.length) * 2 * pi;
      final dx = cx + radius / 350 * 2.2 * _cos(angle);
      final dy = cy + radius / 700 * 2.2 * _sin(angle);

      return Positioned(
        left: null,
        top: null,
        child: Align(
          alignment: Alignment(dx * 2 - 1, dy * 2 - 1),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: colors[i].withOpacity(0.85),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(avatars[i], style: const TextStyle(fontSize: 18)),
            ),
          ),
        ),
      );
    });
  }

  double _cos(double a) => a < 3.14 / 2
      ? 1 - a * a / 2
      : a < 3.14
      ? -(a - 3.14) * (a - 3.14) / 2 + 1 - 1
      : -1 + (a - 3.14) * (a - 3.14) / 2;

  double _sin(double a) => _cos(a - 3.14159 / 2);
}

// ---------- Bottom content ----------
class _BottomContent extends StatelessWidget {
  final _OnboardingData data;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const _BottomContent({
    required this.data,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 15,
                color: AppColors.onSurfaceVariant,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 28),
            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalPages,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: i == currentPage ? 28 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == currentPage
                        ? AppColors.primary
                        : AppColors.outlineVariant,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              label: currentPage < totalPages - 1 ? 'Next' : 'Get Started',
              onPressed: onNext,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onSkip,
              child: Text(
                'SKIP INTRODUCTION',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
