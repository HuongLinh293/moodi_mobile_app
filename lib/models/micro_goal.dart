enum MicroGoalStatus { open, attempted, skipped }

class MicroGoal {
  final String id;
  final String prompt;
  final DateTime createdAt;
  final MicroGoalStatus status;
  final String? followUpNote;

  bool get isCompleted => status == MicroGoalStatus.attempted;

  const MicroGoal({
    required this.id,
    required this.prompt,
    required this.createdAt,
    this.status = MicroGoalStatus.open,
    this.followUpNote,
  });

  MicroGoal copyWith({
    String? id,
    String? prompt,
    DateTime? createdAt,
    MicroGoalStatus? status,
    String? followUpNote,
  }) {
    return MicroGoal(
      id: id ?? this.id,
      prompt: prompt ?? this.prompt,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      followUpNote: followUpNote ?? this.followUpNote,
    );
  }
}
