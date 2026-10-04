import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MindraMotion {
  const MindraMotion(this.reduced);

  final bool reduced;

  factory MindraMotion.of(bool reduced) => MindraMotion(reduced);

  Duration get duration =>
      reduced ? Duration.zero : const Duration(milliseconds: 180);

  Duration get mediumDuration =>
      reduced ? Duration.zero : const Duration(milliseconds: 250);

  Duration get longDuration =>
      reduced ? Duration.zero : const Duration(milliseconds: 800);

  ScrollPhysics get scrollPhysics =>
      reduced ? const ClampingScrollPhysics() : const BouncingScrollPhysics();

  BoxShadow? get cardShadow => reduced
      ? null
      : BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          offset: const Offset(0, 4),
          blurRadius: 16,
        );

  Future<void> selection() async {
    if (reduced) return;
    await HapticFeedback.selectionClick();
  }

  Future<void> light() async {
    if (reduced) return;
    await HapticFeedback.lightImpact();
  }

  Future<void> medium() async {
    if (reduced) return;
    await HapticFeedback.mediumImpact();
  }
}
