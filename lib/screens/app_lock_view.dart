import 'package:flutter/material.dart';

import '../core/theme/colors.dart';
import '../core/theme/motion.dart';
import '../core/theme/typography.dart';
import '../state/mindra_state.dart';

class AppLockView extends StatefulWidget {
  final MindraState state;
  final VoidCallback onUnlocked;

  const AppLockView({super.key, required this.state, required this.onUnlocked});

  @override
  State<AppLockView> createState() => _AppLockViewState();
}

class _AppLockViewState extends State<AppLockView> {
  String _pin = '';
  String? _error;

  static const _demoPin = '0000';

  void _appendDigit(String digit) {
    if (_pin.length >= 4) return;
    MindraMotion.of(widget.state.lowStimulationMode).selection();
    setState(() {
      _pin += digit;
      _error = null;
    });
    if (_pin.length == 4) {
      _verify();
    }
  }

  void _deleteDigit() {
    if (_pin.isEmpty) return;
    MindraMotion.of(widget.state.lowStimulationMode).light();
    setState(() {
      _pin = _pin.substring(0, _pin.length - 1);
      _error = null;
    });
  }

  void _verify() {
    if (_pin == _demoPin) {
      widget.onUnlocked();
      return;
    }
    MindraMotion.of(widget.state.lowStimulationMode).medium();
    setState(() {
      _error = 'Mã chưa đúng. Thử 0000 cho bản demo.';
      _pin = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            children: [
              const Spacer(),
              const Icon(
                Icons.lock_outline_rounded,
                size: 36,
                color: AppColors.ink,
              ),
              const SizedBox(height: 16),
              Text(
                'Không gian của bạn đang được giữ kín',
                textAlign: TextAlign.center,
                style: AppTypography.headlineMedium.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Đây là bản thử nghiệm. Nhập PIN demo 0000 để tiếp tục.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final filled = index < _pin.length;
                  return Container(
                    width: 14,
                    height: 14,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: filled ? AppColors.ink : Colors.transparent,
                      border: Border.all(color: AppColors.ink, width: 1.4),
                    ),
                  );
                }),
              ),
              if (_error != null) ...[
                const SizedBox(height: 14),
                Text(
                  _error!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.orange,
                  ),
                ),
              ],
              const Spacer(),
              _buildPad(),
              const SizedBox(height: 16),
              TextButton(
                onPressed: widget.onUnlocked,
                child: const Text('Bỏ qua lần này'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPad() {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', 'del'],
    ];

    return Column(
      children: keys.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((key) {
            if (key.isEmpty) {
              return const SizedBox(width: 72, height: 72);
            }
            return SizedBox(
              width: 72,
              height: 72,
              child: TextButton(
                onPressed: () =>
                    key == 'del' ? _deleteDigit() : _appendDigit(key),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.ink,
                  shape: const CircleBorder(),
                ),
                child: key == 'del'
                    ? const Icon(Icons.backspace_outlined)
                    : Text(
                        key,
                        style: AppTypography.headlineMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
