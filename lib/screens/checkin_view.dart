import 'package:flutter/material.dart';

import '../core/theme/colors.dart';
import '../core/theme/motion.dart';
import '../core/theme/typography.dart';
import '../models/emotion.dart';
import '../models/journal_entry.dart';
import '../state/mindra_state.dart';
import '../widgets/mood_face.dart';
import 'ai_reflection_view.dart';

class CheckinView extends StatefulWidget {
  final MindraState state;
  final VoidCallback onOpenJournal;
  final VoidCallback? onClose;

  const CheckinView({
    super.key,
    required this.state,
    required this.onOpenJournal,
    this.onClose,
  });

  @override
  State<CheckinView> createState() => _CheckinViewState();
}

class _TriggerOption {
  final String id;
  final String label;

  const _TriggerOption({required this.id, required this.label});
}

class _CheckinViewState extends State<CheckinView> {
  final TextEditingController _situationController = TextEditingController();
  final TextEditingController _thoughtController = TextEditingController();
  final TextEditingController _responseController = TextEditingController();
  late int _intensity;
  bool _isFullCheckin = false;
  bool _isSaving = false;
  String? _selectedTriggerId;

  final List<_TriggerOption> _triggers = const [
    _TriggerOption(id: 'work', label: 'Công việc'),
    _TriggerOption(id: 'family', label: 'Gia đình'),
    _TriggerOption(id: 'friends', label: 'Bạn bè'),
    _TriggerOption(id: 'relationship', label: 'Tình cảm'),
    _TriggerOption(id: 'self_care', label: 'Bản thân'),
    _TriggerOption(id: 'health', label: 'Sức khỏe'),
    _TriggerOption(id: 'rest', label: 'Nghỉ ngơi'),
    _TriggerOption(id: 'finance', label: 'Tài chính'),
    _TriggerOption(id: 'study', label: 'Học tập'),
  ];

  @override
  void initState() {
    super.initState();
    _intensity = widget.state.currentIntensity;
  }

  @override
  void dispose() {
    _situationController.dispose();
    _thoughtController.dispose();
    _responseController.dispose();
    super.dispose();
  }

  Future<void> _offerPlantMoment(String entryId) async {
    if (!mounted) return;
    final keep = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.paper,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        title: Text(
          'Check-in đã được lưu.',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Bạn muốn giữ khoảnh khắc này trong vườn?',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Để sau'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Giữ trong vườn'),
          ),
        ],
      ),
    );
    if (keep == true) {
      widget.state.plantMoment(entryId);
      if (!mounted) return;
      final state = widget.state;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Khoảnh khắc đã được giữ lại.'),
          backgroundColor: AppColors.ink,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          persist: false,
          action: SnackBarAction(
            label: 'Xem trong vườn',
            textColor: AppColors.yellow,
            onPressed: () {
              state.setTab(2);
            },
          ),
        ),
      );
    }
  }

  Future<void> _handleSave({
    bool navigateToJournal = false,
    bool triggerAIReflection = false,
  }) async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    MindraMotion.of(widget.state.lowStimulationMode).medium();

    final entry = JournalEntry(
      id: 'entry-${DateTime.now().millisecondsSinceEpoch}',
      timestamp: DateTime.now(),
      emotionKey: widget.state.selectedEmotionKey,
      intensity: _intensity,
      trigger: _selectedTriggerId ?? 'other',
      situation: _isFullCheckin ? _situationController.text.trim() : '',
      thought: _isFullCheckin ? _thoughtController.text.trim() : '',
      response: _isFullCheckin ? _responseController.text.trim() : '',
    );

    widget.state.addEntry(entry);
    widget.state.setIntensity(_intensity);
    await Future<void>.delayed(
      widget.state.lowStimulationMode || !mounted
          ? Duration.zero
          : const Duration(milliseconds: 180),
    );
    if (!mounted) return;
    await _offerPlantMoment(entry.id);
    if (!mounted) return;

    if (triggerAIReflection && widget.state.aiConsent) {
      if (widget.onClose != null) {
        widget.onClose!();
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AIReflectionView(
            entry: entry,
            state: widget.state,
            onOpenJournal: widget.onOpenJournal,
          ),
        ),
      );
      return;
    }

    if (triggerAIReflection && !widget.state.aiConsent) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'AI phản tư đang tắt. Check-in đã được lưu trên thiết bị.',
            style: AppTypography.caption.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.ink,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    final selectedTrigger = _selectedTriggerId == null
        ? null
        : _triggers.firstWhere((trigger) => trigger.id == _selectedTriggerId);
    final triggerText = selectedTrigger == null
        ? ''
        : ' · Tác nhân: ${selectedTrigger.label}';

    if (!widget.state.isPlanted(entry.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Đã ghi nhận ${widget.state.selectedEmotion.vi.toLowerCase()}$triggerText',
                  style: AppTypography.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.ink,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    if (navigateToJournal) {
      widget.onOpenJournal();
    } else if (widget.onClose != null) {
      widget.onClose!();
    } else {
      widget.onOpenJournal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.state,
      builder: (context, _) => _buildCheckin(context),
    );
  }

  Widget _buildCheckin(BuildContext context) {
    final state = widget.state;
    final selectedKey = state.selectedEmotionKey;
    final selectedEmotion = state.selectedEmotion;
    final toneColor = selectedEmotion.tone;
    final isDarkTone = toneColor.computeLuminance() < 0.42;
    final contentTextColor = isDarkTone ? Colors.white : AppColors.ink;
    final facePaletteColors =
        AppColors.facePalette[selectedEmotion.face] ??
        AppColors.facePalette['calm']!;
    final faceBackground = facePaletteColors[0];
    final faceStroke = facePaletteColors[1];

    return SingleChildScrollView(
      physics: MindraMotion.of(state.lowStimulationMode).scrollPhysics,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('BẮT ĐẦU CHECK-IN', style: AppTypography.kicker),
          const SizedBox(height: 8),
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment<bool>(value: false, label: Text('Nhanh')),
              ButtonSegment<bool>(value: true, label: Text('Đầy đủ')),
            ],
            selected: {_isFullCheckin},
            onSelectionChanged: (selection) {
              MindraMotion.of(state.lowStimulationMode).selection();
              setState(() => _isFullCheckin = selection.first);
            },
          ),
          const SizedBox(height: 6),
          Text(
            _isFullCheckin
                ? 'Thêm bối cảnh nếu bạn muốn hiểu rõ hơn.'
                : 'Chọn cảm xúc và cường độ · khoảng 30 giây',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 18),
          // 1. Hero Selected Emotion Display
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: toneColor,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                Transform.rotate(
                  angle: 0.08,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: faceBackground,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.ink.withValues(alpha: 0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: MoodFace(
                      faceType: selectedEmotion.face,
                      size: 44,
                      backgroundColor: faceBackground,
                      strokeColor: faceStroke,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CẢM XÚC HIỆN TẠI',
                        style: AppTypography.kicker.copyWith(
                          fontSize: 12,
                          color: contentTextColor.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        selectedEmotion.vi,
                        style: AppTypography.headlineMedium.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                          color: contentTextColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        selectedEmotion.promptSubtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: contentTextColor.withValues(alpha: 0.8),
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 2. Thay đổi cảm xúc nhanh (Quick Emotion Switcher)
          Text('CHỌN CẢM XÚC KHÁC NẾU CẦN', style: AppTypography.kicker),
          const SizedBox(height: 10),
          SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: MindraMotion.of(state.lowStimulationMode).scrollPhysics,
              itemCount: MindraEmotions.all.length,
              separatorBuilder: (context, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final key = MindraEmotions.all.keys.elementAt(index);
                final emo = MindraEmotions.all[key]!;
                final isSelected = key == selectedKey;

                return Semantics(
                  button: true,
                  selected: isSelected,
                  label:
                      'Cảm xúc ${emo.vi}${isSelected ? ', đang được chọn' : ''}',
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      MindraMotion.of(state.lowStimulationMode).selection();
                      state.selectEmotion(key);
                    },
                    child: AnimatedContainer(
                      duration: MindraMotion.of(state.lowStimulationMode)
                          .duration,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.ink : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? AppColors.ink : AppColors.line,
                          width: isSelected ? 1.5 : 1.0,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.ink.withValues(alpha: 0.15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MoodFace(faceType: emo.face, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            emo.vi,
                            style: AppTypography.button.copyWith(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              color: isSelected ? Colors.white : AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // 3. Cường độ cảm xúc (1 - 5)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('MỨC ĐỘ CẢM NHẬN', style: AppTypography.kicker),
              Text(
                _getIntensityLabel(_intensity),
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.line),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final level = index + 1;
                final isSelected = _intensity == level;
                return Semantics(
                  button: true,
                  selected: isSelected,
                  label:
                      'Mức độ cảm nhận $level trên 5${isSelected ? ', đang được chọn' : ''}',
                  child: GestureDetector(
                    onTap: () {
                      MindraMotion.of(state.lowStimulationMode).selection();
                      setState(() => _intensity = level);
                    },
                    child: AnimatedContainer(
                      duration: MindraMotion.of(state.lowStimulationMode)
                          .duration,
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.ink : AppColors.cream,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.ink
                              : AppColors.lineLight,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$level',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: isSelected ? AppColors.yellow : AppColors.ink,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 24),

          if (_isFullCheckin) ...[
            Text('TÁC NHÂN (TÙY CHỌN)', style: AppTypography.kicker),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _triggers.map((trigger) {
                final isSelected = _selectedTriggerId == trigger.id;
                return Semantics(
                  button: true,
                  selected: isSelected,
                  label:
                      'Tác nhân ${trigger.label}${isSelected ? ', đang được chọn' : ''}',
                  child: GestureDetector(
                    onTap: () {
                      MindraMotion.of(state.lowStimulationMode).selection();
                      setState(() {
                        _selectedTriggerId = isSelected ? null : trigger.id;
                      });
                    },
                    child: AnimatedContainer(
                      constraints: const BoxConstraints(minHeight: 44),
                      duration: MindraMotion.of(state.lowStimulationMode)
                          .duration,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.ink : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.ink : AppColors.line,
                        ),
                      ),
                      child: Text(
                        '# ${trigger.label}',
                        style: AppTypography.caption.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            _buildTextInput(
              label: 'Tình huống',
              hint: 'Điều gì đã xảy ra?',
              controller: _situationController,
            ),
            const SizedBox(height: 16),
            _buildTextInput(
              label: 'Suy nghĩ tự động',
              hint: 'Điều gì đã lướt qua tâm trí bạn?',
              controller: _thoughtController,
            ),
            const SizedBox(height: 16),
            _buildTextInput(
              label: 'Phản ứng',
              hint: 'Sau đó bạn đã làm gì?',
              controller: _responseController,
            ),
            const SizedBox(height: 28),
          ] else
            const SizedBox(height: 28),

          // 6. Action Buttons
          if (!_isFullCheckin) ...[
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isSaving ? null : () => _handleSave(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ink,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  _isSaving ? 'Đang lưu...' : 'Lưu check-in nhanh',
                  style: AppTypography.button.copyWith(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ] else if (widget.state.aiConsent) ...[
            // Primary AI Reflection Action
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isSaving
                    ? null
                    : () => _handleSave(triggerAIReflection: true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ink,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('✨', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      _isSaving ? 'Đang lưu...' : 'Lưu & Phản tư cùng AI',
                      style: AppTypography.button.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: _isSaving
                    ? null
                    : () => _handleSave(navigateToJournal: false),
                child: Text(
                  'Chỉ lưu check-in này',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ] else ...[
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isSaving
                    ? null
                    : () => _handleSave(navigateToJournal: false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.ink,
                  foregroundColor: AppColors.yellow,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 20,
                      color: AppColors.yellow,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isSaving ? 'Đang lưu...' : 'Lưu check-in đầy đủ',
                      style: AppTypography.button.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () => _handleSave(navigateToJournal: true),
                child: Text(
                  'Lưu & Xem dòng thời gian nhật ký →',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextInput({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return TextField(
      key: ValueKey<String>(label),
      controller: controller,
      maxLines: 3,
      style: AppTypography.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.line),
        ),
      ),
    );
  }

  String _getIntensityLabel(int level) {
    switch (level) {
      case 1:
        return '1/5 · Thoang thoảng';
      case 2:
        return '2/5 · Nhẹ nhàng';
      case 3:
        return '3/5 · Rõ rệt';
      case 4:
        return '4/5 · Rất mạnh';
      case 5:
        return '5/5 · Choáng ngợp';
      default:
        return '3/5 · Rõ rệt';
    }
  }
}
