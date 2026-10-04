import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/colors.dart';
import '../core/theme/motion.dart';
import '../core/theme/typography.dart';
import '../state/mindra_state.dart';
import 'today_view.dart';
import 'checkin_view.dart';
import 'practice_view.dart';
import 'garden_view.dart';
import 'journal_view.dart';
import 'explore_view.dart';
import 'settings_view.dart';
import 'pause_mode_sheet.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<MindraState>();
    final currentTab = state.currentTab;

    final motion = MindraMotion.of(state.lowStimulationMode);
    return Scaffold(
      backgroundColor: AppColors.paper,
      appBar: PreferredSize(
        // PreferredSize must include the status-bar inset because the custom
        // app bar also uses SafeArea internally.
        preferredSize: Size.fromHeight(58 + MediaQuery.paddingOf(context).top),
        child: _buildFlexibleAppBar(context, state, currentTab, motion),
      ),
      body: AnimatedSwitcher(
        duration: motion.mediumDuration,
        transitionBuilder: (child, animation) =>
            FadeTransition(opacity: animation, child: child),
        child: KeyedSubtree(
          key: ValueKey<int>(currentTab),
          child: _buildView(state, currentTab),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, state, currentTab, motion),
    );
  }

  Widget _buildFlexibleAppBar(
    BuildContext context,
    MindraState state,
    int currentTab,
    MindraMotion motion,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.paper.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(color: AppColors.ink.withValues(alpha: 0.08)),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: AnimatedSwitcher(
            duration: motion.duration,
            child: KeyedSubtree(
              key: ValueKey<int>(currentTab),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isCompact = constraints.maxWidth < 380;
                  return SizedBox(
                    height: 58,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: _buildAppBarLeading(
                                context,
                                state,
                                currentTab,
                                isCompact,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                              child: _buildAppBarTrailing(
                                context,
                                state,
                                currentTab,
                                isCompact,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarLeading(
    BuildContext context,
    MindraState state,
    int currentTab,
    bool isCompact,
  ) {
    switch (currentTab) {
      case 0:
        // Trang Hôm nay: Wordmark thương hiệu
        return RichText(
          text: TextSpan(
            style: AppTypography.headlineLarge.copyWith(
              fontSize: isCompact ? 19 : 23,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.2,
            ),
            children: [
              const TextSpan(text: 'mind'),
              TextSpan(
                text: 'r',
                style: TextStyle(color: AppColors.orange),
              ),
              TextSpan(
                text: 'a',
                style: TextStyle(
                  color: AppColors.blue,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        );

      case 1:
        // Calendar
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.orange.withValues(alpha: 0.16),
              ),
              child: const Center(
                child: Icon(
                  Icons.calendar_month_rounded,
                  size: 18,
                  color: AppColors.orange,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Nhật ký',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ],
        );

      case 2:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mint.withValues(alpha: 0.2),
              ),
              child: const Center(
                child: Icon(
                  Icons.local_florist_rounded,
                  size: 18,
                  color: AppColors.ink,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Khu vườn',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ],
        );

      case 3:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blue.withValues(alpha: 0.16),
              ),
              child: const Center(
                child: Icon(
                  Icons.explore_outlined,
                  size: 18,
                  color: AppColors.blue,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Khám phá',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAppBarTrailing(
    BuildContext context,
    MindraState state,
    int currentTab,
    bool isCompact,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Streak indicator (ở tab Hôm nay)
        if (currentTab == 0)
          Semantics(
            label: 'Chuỗi hiện diện: ${state.consecutiveWeeks} tuần',
            child: Container(
              margin: EdgeInsets.only(right: isCompact ? 6 : 10),
              padding: EdgeInsets.symmetric(
                horizontal: isCompact ? 7 : 9,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: AppColors.creamDark,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.lineLight),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 4),
                  Text(
                    isCompact
                        ? '${state.consecutiveWeeks}'
                        : '${state.consecutiveWeeks} tuần',
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Mục Tôi mở hồ sơ, cài đặt và thông tin.
        Semantics(
          button: true,
          label: 'Tôi: hồ sơ và cài đặt',
          child: InkWell(
            onTap: () => _openProfileModal(context, state),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: isCompact ? 28 : 32,
                    height: isCompact ? 28 : 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.ink,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'L',
                      style: AppTypography.button.copyWith(
                        fontSize: 13,
                        color: AppColors.yellow,
                      ),
                    ),
                  ),
                  SizedBox(width: isCompact ? 4 : 7),
                  Text(
                    'Tôi',
                    style: AppTypography.button.copyWith(
                      fontSize: isCompact ? 11 : 12,
                      color: AppColors.ink,
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

  void _openProfileModal(BuildContext context, MindraState state) {
    MindraMotion.of(state.lowStimulationMode).medium();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalCtx) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          decoration: const BoxDecoration(
            color: AppColors.paper,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.line,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.ink,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'L',
                        style: AppTypography.headlineMedium.copyWith(
                          color: AppColors.yellow,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Linh',
                          style: AppTypography.titleLarge.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          state.userEmail,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.line),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${state.totalCheckins}',
                            style: AppTypography.titleLarge.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text('Lần check-in', style: AppTypography.caption),
                        ],
                      ),
                      Container(height: 28, width: 1, color: AppColors.line),
                      Column(
                        children: [
                          Text(
                            '${state.consecutiveWeeks} tuần',
                            style: AppTypography.titleLarge.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text('Kiên trì', style: AppTypography.caption),
                        ],
                      ),
                      Container(height: 28, width: 1, color: AppColors.line),
                      Column(
                        children: [
                          Text(
                            '${state.positivePercentage.round()}%',
                            style: AppTypography.titleLarge.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.mint,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text('Tích cực / Yên', style: AppTypography.caption),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.settings_rounded,
                          color: AppColors.ink,
                        ),
                        title: Text(
                          'Cài đặt & Bảo mật',
                          style: AppTypography.bodyMedium,
                        ),
                        trailing: const Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.pop(modalCtx);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => Scaffold(
                                backgroundColor: AppColors.paper,
                                appBar: AppBar(
                                  backgroundColor: AppColors.paper,
                                  elevation: 0,
                                  scrolledUnderElevation: 0,
                                  leading: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_rounded,
                                      color: AppColors.ink,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  title: Text(
                                    'Cài đặt & Riêng tư',
                                    style: AppTypography.titleMedium.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  centerTitle: false,
                                ),
                                body: SettingsView(state: state),
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.ink,
                        ),
                        title: Text(
                          'Về Mindra',
                          style: AppTypography.bodyMedium,
                        ),
                        trailing: Text('v1.0.0', style: AppTypography.caption),
                        onTap: () => Navigator.pop(modalCtx),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.logout_rounded,
                          color: Colors.red.shade700,
                        ),
                        title: Text(
                          'Đăng xuất',
                          style: AppTypography.bodyMedium.copyWith(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right_rounded,
                          size: 20,
                          color: Colors.red.shade300,
                        ),
                        onTap: () {
                          Navigator.pop(modalCtx);
                          _showLogoutDialog(context, state);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context, MindraState state) {
    MindraMotion.of(state.lowStimulationMode).light();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: Text(
          'Đăng xuất khỏi Mindra?',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Bạn sẽ cần đăng nhập lại để truy cập không gian cá nhân và các tính năng đồng bộ.',
          style: AppTypography.bodySmall,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Ở lại',
              style: TextStyle(color: AppColors.textTertiary),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              state.logout();
            },
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }

  void _openCheckinModal(BuildContext context, MindraState state) {
    MindraMotion.of(state.lowStimulationMode).light();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalCtx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.90,
          decoration: const BoxDecoration(
            color: AppColors.paper,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.ink.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 14, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Check-in cảm xúc',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 22,
                          color: AppColors.ink,
                        ),
                        onPressed: () => Navigator.pop(modalCtx),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.line),
                Expanded(
                  child: CheckinView(
                    state: state,
                    onClose: () => Navigator.pop(modalCtx),
                    onOpenJournal: () {
                      Navigator.pop(modalCtx);
                      state.setTab(1); // Calendar tab
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openPauseModeModal(BuildContext context, MindraState state) {
    MindraMotion.of(state.lowStimulationMode).light();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalCtx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.90,
          decoration: const BoxDecoration(
            color: AppColors.paper,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.ink.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 14, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.mint.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.pause_circle_filled_rounded,
                                  size: 16,
                                  color: AppColors.ink,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Pause Mode',
                                  style: AppTypography.caption.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.ink,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Dừng lại 30s',
                            style: AppTypography.titleMedium.copyWith(
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 22,
                          color: AppColors.ink,
                        ),
                        onPressed: () => Navigator.pop(modalCtx),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.line),
                Expanded(
                  child: PauseModeSheet(
                    state: state,
                    onClose: () => Navigator.pop(modalCtx),
                    onOpenFullCheckin: () {
                      Navigator.pop(modalCtx);
                      _openCheckinModal(context, state);
                    },
                    onOpenPractice: () {
                      Navigator.pop(modalCtx);
                      _openPracticePage(state);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openPracticePage(MindraState state) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: AppColors.paper,
          appBar: AppBar(
            backgroundColor: AppColors.paper,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              'Bài tập ngắn',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: PracticeView(state: state),
        ),
      ),
    );
  }

  Widget _buildView(MindraState state, int tab) {
    switch (tab) {
      case 0: // Home
        return TodayView(
          state: state,
          onOpenCheckin: () => _openCheckinModal(context, state),
          onOpenJournal: () => state.setTab(1),
          onOpenPause: () => _openPauseModeModal(context, state),
          onOpenPractice: () => _openPracticePage(state),
          onOpenGarden: () => state.setTab(2),
        );
      case 1:
        return JournalView(state: state);
      case 2:
        return GardenView(
          state: state,
          onOpenCheckin: () => _openCheckinModal(context, state),
          onOpenJournal: () => state.setTab(1),
        );
      case 3:
        return ExploreView(
          state: state,
          onOpenCheckin: () => _openCheckinModal(context, state),
        );
      default:
        return TodayView(
          state: state,
          onOpenCheckin: () => _openCheckinModal(context, state),
          onOpenJournal: () => state.setTab(1),
          onOpenPause: () => _openPauseModeModal(context, state),
          onOpenPractice: () => _openPracticePage(state),
          onOpenGarden: () => state.setTab(2),
        );
    }
  }

  Widget _buildBottomNav(
    BuildContext context,
    MindraState state,
    int currentTab,
    MindraMotion motion,
  ) {
    final textScale = MediaQuery.textScalerOf(context).scale(9) / 9;
    final navHeight = textScale > 1 ? 74 + 28 * (textScale - 1) : 72.0;
    final items = [
      (icon: Icons.home_outlined, label: 'Hôm nay'),
      (icon: Icons.menu_book_outlined, label: 'Nhật ký'),
      (icon: Icons.local_florist_outlined, label: 'Khu vườn'),
      (icon: Icons.explore_outlined, label: 'Khám phá'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cream.withValues(alpha: 0.96),
        border: Border(
          top: BorderSide(color: AppColors.ink.withValues(alpha: 0.1)),
        ),
        boxShadow: motion.reduced
            ? const []
            : [
                BoxShadow(
                  color: AppColors.ink.withValues(alpha: 0.06),
                  offset: const Offset(0, -6),
                  blurRadius: 20,
                ),
              ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: navHeight,
          child: Row(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = currentTab == index;

              return Expanded(
                child: Semantics(
                  button: true,
                  selected: isActive,
                  label: '${item.label}${isActive ? ', selected' : ''}',
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => state.setTab(index),
                      borderRadius: BorderRadius.circular(14),
                      child: AnimatedContainer(
                        duration: motion.duration,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.yellow
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              item.icon,
                              size: 20,
                              color: isActive
                                  ? AppColors.ink
                                  : AppColors.textMuted,
                            ),
                            const SizedBox(height: 2),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                item.label,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: AppTypography.kicker.copyWith(
                                  fontSize: 11,
                                  letterSpacing: 0.1,
                                  color: isActive
                                      ? AppColors.ink
                                      : AppColors.textMuted,
                                  fontWeight: isActive
                                      ? FontWeight.w800
                                      : FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
