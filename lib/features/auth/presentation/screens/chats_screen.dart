import 'package:flutter/material.dart';
import 'package:goldiss_chat/Core/app_theme.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F0FC),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildAppBar(),
                _buildSearchBar(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const SizedBox(height: 20),
                      _buildSectionLabel('PINNED'),
                      const SizedBox(height: 12),
                      _buildPinnedCard(
                        name: 'Haruto Sato',
                        message: 'Wait, check the coordinates again!...',
                        time: '12:45 PM',
                        hasUnread: false,
                        avatarColor: const Color(0xFF3D2C8D),
                      ),
                      const SizedBox(height: 10),
                      _buildPinnedCard(
                        name: "Yuna's Squad",
                        message: 'Yuna: Project Alpha is live 🚀',
                        time: '11:20 AM',
                        hasUnread: true,
                        unreadCount: 3,
                        isGroup: true,
                        avatarColor: const Color(0xFFE8E0F5),
                        messageColor: AppColors.primary,
                        avatarWidget: _whiteHairAvatar(),
                      ),
                      const SizedBox(height: 24),
                      _buildSectionLabel('RECENT CHATS'),
                      const SizedBox(height: 8),
                      _buildRecentRow(
                        name: 'Ren Takahashi',
                        message: 'Typing...',
                        time: 'Just now',
                        isTyping: true,
                        avatarColor: const Color(0xFF1A3A2A),
                        highlighted: false,
                      ),
                      _buildDivider(),
                      _buildRecentRow(
                        name: 'Mika Azumi',
                        message: 'Did you see the new art? 🎨',
                        time: '09:42 AM',
                        unreadCount: 5,
                        avatarColor: const Color(0xFF1A0A2A),
                        highlighted: true,
                        timeColor: AppColors.primary,
                      ),
                      _buildDivider(),
                      _buildRecentRow(
                        name: 'Kenji Wilson',
                        message: 'The meeting is moved to 4 PM.',
                        time: 'Yesterday',
                        avatarColor: const Color(0xFF2A0A0A),
                        highlighted: false,
                      ),
                      _buildDivider(),
                      _buildRecentRow(
                        name: 'Elena Rossi',
                        message: 'That was such a fun stream!',
                        time: 'Yesterday',
                        avatarColor: const Color(0xFF3A1A0A),
                        highlighted: false,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
            // FAB
            Positioned(
              bottom: 24,
              right: 20,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryGradient,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
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
          // User avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF7B5FE0), Color(0xFFFF4F8B)],
              ),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 10),
          const Text(
            'Goldiss Chat',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const Spacer(),
          Icon(Icons.search, color: AppColors.primary, size: 26),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            const Icon(Icons.search, color: AppColors.outline, size: 20),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Search chats...',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 15,
                  color: AppColors.outlineVariant,
                ),
              ),
            ),
            const Icon(Icons.tune, color: AppColors.outline, size: 20),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (text == 'PINNED')
            const Icon(
              Icons.push_pin_outlined,
              size: 14,
              color: AppColors.outline,
            ),
          if (text == 'PINNED') const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.outline,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinnedCard({
    required String name,
    required String message,
    required String time,
    bool hasUnread = false,
    int unreadCount = 0,
    bool isGroup = false,
    required Color avatarColor,
    Color messageColor = AppColors.onSurfaceVariant,
    Widget? avatarWidget,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                avatarWidget ??
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: avatarColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white60,
                        size: 28,
                      ),
                    ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const Spacer(),
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
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 13,
                            color: messageColor,
                            fontWeight: messageColor == AppColors.primary
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (unreadCount > 0)
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$unreadCount',
                              style: const TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 11,
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
          ],
        ),
      ),
    );
  }

  Widget _buildRecentRow({
    required String name,
    required String message,
    required String time,
    bool isTyping = false,
    int unreadCount = 0,
    required Color avatarColor,
    bool highlighted = false,
    Color timeColor = AppColors.outline,
  }) {
    return Container(
      color: highlighted
          ? AppColors.surfaceContainerLow.withOpacity(0.7)
          : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: avatarColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white60,
                  size: 28,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: highlighted
                          ? AppColors.surfaceContainerLow
                          : const Color(0xFFF4F0FC),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      time,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 12,
                        fontWeight: unreadCount > 0
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: timeColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 13,
                          color: AppColors.onSurfaceVariant,
                          fontStyle: isTyping
                              ? FontStyle.italic
                              : FontStyle.normal,
                        ),
                      ),
                    ),
                    if (unreadCount > 0)
                      Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$unreadCount',
                            style: const TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    else
                      const Icon(
                        Icons.done_all,
                        size: 16,
                        color: AppColors.outlineVariant,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 86),
      child: Divider(height: 1, color: Color(0xFFE8E4F0)),
    );
  }
}

Widget _whiteHairAvatar() {
  return Container(
    width: 52,
    height: 52,
    decoration: BoxDecoration(
      color: const Color(0xFFE8E0F5),
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: ClipOval(child: CustomPaint(painter: _WhiteHairPainter())),
  );
}

class _WhiteHairPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Face
    final face = Paint()..color = const Color(0xFFFFE4C4);
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.55),
      size.width * 0.3,
      face,
    );
    // Hair
    final hair = Paint()..color = const Color(0xFFE0E0E0);
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.35),
      size.width * 0.34,
      hair,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}
