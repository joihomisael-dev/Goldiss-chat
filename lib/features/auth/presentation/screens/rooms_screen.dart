import 'package:flutter/material.dart';
import 'package:goldiss_chat/Core/app_theme.dart';
import '../widgets/goldiss_logo.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All Rooms', 'Anime', 'Gaming', 'Music'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // AppBar
                SliverToBoxAdapter(child: _buildAppBar()),
                // Filter chips
                SliverToBoxAdapter(child: _buildFilters()),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                // Trending card
                SliverToBoxAdapter(child: _buildTrendingCard()),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
                // Room of the Day
                SliverToBoxAdapter(child: _buildRoomOfTheDay()),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                // Explore Communities header
                SliverToBoxAdapter(child: _buildSectionHeader()),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                // Community list
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        _buildCommunityCard(_communities[index]),
                    childCount: _communities.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
            // FAB
            Positioned(bottom: 24, right: 20, child: _buildFAB()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          GoldissLogoSmall(size: 38),
          const SizedBox(width: 10),
          const Text(
            'Goldiss Chat',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const Spacer(),
          Icon(Icons.search, color: AppColors.primary, size: 26),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final selected = i == _selectedFilter;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : AppColors.outlineVariant,
                  width: 1.5,
                ),
              ),
              child: Text(
                _filters[i],
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : AppColors.onSurfaceVariant,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2A1060), Color(0xFF4A2090), Color(0xFF1A2060)],
          ),
        ),
        child: Stack(
          children: [
            // City background overlay
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomPaint(
                size: const Size(double.infinity, 220),
                painter: _CyberpunkCityPainter(),
              ),
            ),
            // Trending badge
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'TRENDING',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cyberpunk Nights',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Deep discussions about sci-fi lore and gaming.',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          '3.4k Active Now',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomOfTheDay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.group,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.outlineVariant),
                  ),
                  child: const Text(
                    'Room of the Day',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const Text(
              'Anime Theory Lab',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Breaking down the latest seasonal finales with extreme precision.',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 14,
                color: AppColors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                ..._buildAvatarStack(),
                const SizedBox(width: 8),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '+82',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAvatarStack() {
    final colors = [const Color(0xFF7986CB), const Color(0xFFAB8FFE)];
    return List.generate(2, (i) {
      return Transform.translate(
        offset: Offset(i * -8.0, 0),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: colors[i],
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 14),
        ),
      );
    });
  }

  Widget _buildSectionHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const Text(
            'Explore Communities',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.onSurface,
            ),
          ),
          const Spacer(),
          Text(
            'View All',
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCard(_CommunityData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: data.bgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CustomPaint(painter: _ThumbnailPainter(data.bgColor)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _Tag(data.tag),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: AppColors.outline,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        data.time,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 11,
                          color: AppColors.outline,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.active,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: AppColors.primaryGradient),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  const _Tag(this.text);

  static const Map<String, Color> _colors = {
    'GAMING': Color(0xFF4CAF50),
    'WEBTOON': Color(0xFFFF9800),
    'MUSIC': Color(0xFF2196F3),
    'ANIME': Color(0xFF9C27B0),
  };

  @override
  Widget build(BuildContext context) {
    final color = _colors[text] ?? AppColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _CommunityData {
  final String name, description, active, tag, time;
  final Color bgColor;
  const _CommunityData({
    required this.name,
    required this.description,
    required this.active,
    required this.tag,
    required this.time,
    required this.bgColor,
  });
}

const List<_CommunityData> _communities = [
  _CommunityData(
    name: "Speedrunner's Hub",
    description: 'New world records just dropped in Eld...',
    active: '1.2k Active',
    tag: 'GAMING',
    time: '10m ago',
    bgColor: Color(0xFF1A1A2E),
  ),
  _CommunityData(
    name: 'Daily Webtoon Club',
    description: "Reading 'Tower of God' latest chapter...",
    active: '856 Active',
    tag: 'WEBTOON',
    time: '2h ago',
    bgColor: Color(0xFFFFF8E1),
  ),
  _CommunityData(
    name: 'Lo-Fi Beats & Chill',
    description: 'Sharing obscure jazzhop playlists from...',
    active: '4.2k Active',
    tag: 'MUSIC',
    time: '5m ago',
    bgColor: Color(0xFF1A1A2E),
  ),
  _CommunityData(
    name: 'Cosplay Workshop',
    description: 'Building props for the upcoming conv...',
    active: '234 Active',
    tag: 'ANIME',
    time: 'Now',
    bgColor: Color(0xFF0D0D0D),
  ),
];

class _CyberpunkCityPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Neon buildings
    final neonColors = [
      const Color(0xFF00FFFF),
      const Color(0xFFFF00FF),
      const Color(0xFF7B5FE0),
      const Color(0xFF00FF88),
    ];

    final buildingData = [
      [0.0, 0.7, 0.08, 1.0],
      [0.07, 0.5, 0.06, 1.0],
      [0.12, 0.6, 0.07, 1.0],
      [0.18, 0.3, 0.09, 1.0],
      [0.26, 0.55, 0.06, 1.0],
      [0.31, 0.4, 0.08, 1.0],
      [0.38, 0.25, 0.1, 1.0],
      [0.47, 0.5, 0.07, 1.0],
      [0.53, 0.35, 0.09, 1.0],
      [0.61, 0.55, 0.06, 1.0],
      [0.66, 0.3, 0.1, 1.0],
      [0.75, 0.5, 0.08, 1.0],
      [0.82, 0.4, 0.07, 1.0],
      [0.88, 0.6, 0.08, 1.0],
      [0.95, 0.75, 0.05, 1.0],
    ];

    for (int i = 0; i < buildingData.length; i++) {
      final b = buildingData[i];
      final paint = Paint()
        ..color = Color.lerp(
          const Color(0xFF0D0920),
          const Color(0xFF1A1040),
          i / buildingData.length,
        )!
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromLTRB(
          b[0] * size.width,
          b[1] * size.height,
          (b[0] + b[2]) * size.width,
          b[3] * size.height,
        ),
        paint,
      );

      // Neon window lines
      if (i % 3 == 0) {
        final neonPaint = Paint()
          ..color = neonColors[i % neonColors.length].withOpacity(0.6)
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;

        canvas.drawLine(
          Offset((b[0] + b[2] / 2) * size.width, b[1] * size.height),
          Offset((b[0] + b[2] / 2) * size.width, (b[1] + 0.05) * size.height),
          neonPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _ThumbnailPainter extends CustomPainter {
  final Color bg;
  _ThumbnailPainter(this.bg);

  @override
  void paint(Canvas canvas, Size size) {
    final isDark = bg.computeLuminance() < 0.3;
    final paint = Paint()
      ..color = isDark
          ? Colors.white.withOpacity(0.07)
          : Colors.black.withOpacity(0.06)
      ..style = PaintingStyle.fill;

    // Simple geometric pattern
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.3),
      size.width * 0.35,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.7),
      size.width * 0.25,
      paint,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}
