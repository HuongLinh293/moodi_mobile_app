class JournalEntry {
  final String id;
  final DateTime timestamp;
  final String emotionKey;
  final int intensity;
  final String trigger;
  final String situation;
  final String thought;
  final String response;
  final String? exerciseId;
  final bool exerciseDone;
  final int? afterIntensity;
  final String? afterEmotionKey;
  final int? usefulnessRating;
  final int? easeRating;
  final String? repeatPreference;

  const JournalEntry({
    required this.id,
    required this.timestamp,
    required this.emotionKey,
    required this.intensity,
    this.trigger = 'other',
    this.situation = '',
    this.thought = '',
    this.response = '',
    this.exerciseId,
    this.exerciseDone = false,
    this.afterIntensity,
    this.afterEmotionKey,
    this.usefulnessRating,
    this.easeRating,
    this.repeatPreference,
  });

  JournalEntry copyWith({
    String? id,
    DateTime? timestamp,
    String? emotionKey,
    int? intensity,
    String? trigger,
    String? situation,
    String? thought,
    String? response,
    String? exerciseId,
    bool? exerciseDone,
    int? afterIntensity,
    String? afterEmotionKey,
    int? usefulnessRating,
    int? easeRating,
    String? repeatPreference,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      emotionKey: emotionKey ?? this.emotionKey,
      intensity: intensity ?? this.intensity,
      trigger: trigger ?? this.trigger,
      situation: situation ?? this.situation,
      thought: thought ?? this.thought,
      response: response ?? this.response,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseDone: exerciseDone ?? this.exerciseDone,
      afterIntensity: afterIntensity ?? this.afterIntensity,
      afterEmotionKey: afterEmotionKey ?? this.afterEmotionKey,
      usefulnessRating: usefulnessRating ?? this.usefulnessRating,
      easeRating: easeRating ?? this.easeRating,
      repeatPreference: repeatPreference ?? this.repeatPreference,
    );
  }
}
