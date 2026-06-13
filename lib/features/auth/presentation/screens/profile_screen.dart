import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goldiss_chat/Core/app_theme.dart';
import 'package:goldiss_chat/features/auth/presentation/provider/auth_provider.dart';
import 'package:goldiss_chat/features/auth/presentation/provider/auth_state.dart';
import 'package:goldiss_chat/features/auth/presentation/widgets/primary_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider.notifier);
    final state = ref.watch(authProvider);
    // Effet de bord : navigation
    ref.listen(authProvider, (prev, next) {
      if (next.user == null) {
        print(next.user);
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildIdentity(state),
                      const SizedBox(height: 20),
                      _buildStatsCard(),
                      const SizedBox(height: 16),
                      _buildAboutCard(),
                      const SizedBox(height: 16),
                      _buildInterestsCard(),
                      const SizedBox(height: 16),
                      _buildAchievementsCard(),
                      const SizedBox(height: 16),
                      _buildRecentActivityCard(),
                      const SizedBox(height: 16),
                      _buildDeconnexionCard(auth, state),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Edit FAB
          Positioned(
            bottom: 24,
            right: 20,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.primaryGradient,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Banner
        Container(
          height: 180,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2A1060), Color(0xFF6040C0), Color(0xFFD06090)],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  _buildLogoText(),
                  const Spacer(),
                  const Icon(Icons.search, color: Colors.white, size: 24),
                ],
              ),
            ),
          ),
        ),
        // Avatar
        Positioned(
          bottom: -50,
          left: 20,
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF7B5FE0), Color(0xFFFF4F8B)],
              ),
            ),
            child: ClipOval(child: CustomPaint(painter: _AuraPainter())),
          ),
        ),
        // Settings button
        Positioned(
          bottom: -44,
          right: 20,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoText() {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 8),
        const Text(
          'Goldiss Chat',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildIdentity(AuthState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 52), // space for avatar
        const Text(
          'Aura_Vibes',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 14,
              color: AppColors.outline,
            ),
            const SizedBox(width: 4),
            const Text(
              'Neo Tokyo Sect-7',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 13,
                color: AppColors.outline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(Icons.email, size: 14, color: AppColors.outline),
            const SizedBox(width: 4),
            Text(
              '${state.user?.email}',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 13,
                color: AppColors.outline,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
        Row(
          children: [
            _buildFollowButton(),
            const SizedBox(width: 12),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.outlineVariant, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.mail_outline,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFollowButton() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: AppColors.primaryGradient),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'Follow',
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(child: _buildStat('12.4k', 'FOLLOWERS')),
            VerticalDivider(
              color: AppColors.outlineVariant,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(child: _buildStat('84', 'GROUPS')),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.outline,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                color: AppColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'About Me',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Digital nomad living in the intersections of lo-fi beats and competitive esports. Chronicling my journey through the neon-lit alleys of the metaverse. Let\'s chat about 90s manga or the latest tech! 🌐✨',
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 14,
              color: AppColors.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestsCard() {
    const interests = ['MANGA', 'LO-FI', 'ESPORTS', 'CYBERPUNK', 'SYNTHWAVE'];
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interests',
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: interests.map((tag) => _InterestChip(tag)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Achievements',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const Spacer(),
              const Text(
                'VIEW ALL',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _AchievementBadge(
                icon: Icons.star,
                label: 'FOUNDER',
                color: const Color(0xFFFFA726),
              ),
              const SizedBox(width: 12),
              _AchievementBadge(
                icon: Icons.bolt,
                label: 'TOP 1%',
                color: const Color(0xFF42A5F5),
              ),
              const SizedBox(width: 12),
              _AchievementBadge(
                icon: Icons.favorite,
                label: 'CURATOR',
                color: const Color(0xFFEC407A),
              ),
              const SizedBox(width: 12),
              _AchievementBadge(
                icon: Icons.lock_outline,
                label: 'HIDDEN',
                color: AppColors.outlineVariant,
                locked: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const Spacer(),
              const Icon(Icons.more_horiz, color: AppColors.outline),
            ],
          ),
          const SizedBox(height: 16),
          _ActivityRow(
            icon: Icons.chat_bubble_outline,
            iconBg: AppColors.surfaceContainerLow,
            text: 'Joined the ',
            highlight: '#NeonDreams',
            suffix: ' room',
            time: '2 hours ago',
          ),
          const SizedBox(height: 14),
          _ActivityRow(
            icon: Icons.palette_outlined,
            iconBg: AppColors.surfaceContainerLow,
            text: 'Updated profile banner art',
            time: 'Yesterday at 11:45 PM',
          ),
        ],
      ),
    );
  }
}

Widget _buildDeconnexionCard(AuthNotifier auth, AuthState state) {
  return _Card(
    child: PrimaryButton(
      label: 'Sign out',
      isloading: state.isLoading,
      onPressed: state.isLoading ? null : () => auth.signOut(),
    ),
  );
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _InterestChip extends StatelessWidget {
  final String label;
  const _InterestChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool locked;

  const _AchievementBadge({
    required this.icon,
    required this.label,
    required this.color,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: locked ? AppColors.surfaceContainerHigh : color,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: locked ? AppColors.outline : Colors.white,
            size: 26,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: locked ? AppColors.outline : AppColors.onSurfaceVariant,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String text;
  final String? highlight;
  final String? suffix;
  final String time;

  const _ActivityRow({
    required this.icon,
    required this.iconBg,
    required this.text,
    this.highlight,
    this.suffix,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 14,
                    color: AppColors.onSurface,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(text: text),
                    if (highlight != null)
                      TextSpan(
                        text: highlight,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    if (suffix != null) TextSpan(text: suffix),
                  ],
                ),
              ),
              const SizedBox(height: 3),
              Text(
                time,
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 12,
                  color: AppColors.outline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AuraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background
    final bg = Paint()
      ..color = const Color(0xFF1A0A3A)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bg);

    // Face
    final face = Paint()..color = const Color(0xFFFFD5B0);
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.6),
      size.width * 0.3,
      face,
    );

    // Pink hair
    final hair = Paint()..color = const Color(0xFFFF6EA0);
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.36,
      hair,
    );

    // Neon eye glow
    final glow = Paint()
      ..color = const Color(0xFF00FFFF).withOpacity(0.7)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(Offset(size.width * 0.42, size.height * 0.57), 3, glow);
    canvas.drawCircle(Offset(size.width * 0.58, size.height * 0.57), 3, glow);

    // Jacket collar
    final jacket = Paint()..color = const Color(0xFF1A1A2E);
    final path = Path()
      ..moveTo(size.width * 0.1, size.height)
      ..lineTo(size.width * 0.9, size.height)
      ..lineTo(size.width * 0.85, size.height * 0.82)
      ..lineTo(size.width * 0.5, size.height * 0.75)
      ..lineTo(size.width * 0.15, size.height * 0.82)
      ..close();
    canvas.drawPath(path, jacket);

    // Neon collar trim
    final trim = Paint()
      ..color = const Color(0xFF7B5FE0)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, trim);
  }

  @override
  bool shouldRepaint(_) => false;
}
