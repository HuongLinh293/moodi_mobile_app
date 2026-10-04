import 'journal_entry.dart';

class GardenMoment {
  final String id;
  final String entryId;
  final String monthKey;
  final int bedIndex;
  final int slotIndex;
  final DateTime plantedAt;
  final int appearanceVariant;

  const GardenMoment({
    required this.id,
    required this.entryId,
    required this.monthKey,
    required this.bedIndex,
    required this.slotIndex,
    required this.plantedAt,
    this.appearanceVariant = 0,
  });

  static String monthKeyFor(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month';
  }

  static String captionFor(JournalEntry entry) {
    if (entry.situation.trim().isNotEmpty) return entry.situation.trim();
    if (entry.thought.trim().isNotEmpty) return entry.thought.trim();
    return '';
  }
}

class GardenBedGroup {
  final int bedIndex;
  final List<GardenMoment> moments;

  const GardenBedGroup({required this.bedIndex, required this.moments});
}
