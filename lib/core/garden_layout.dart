class GardenSlot {
  final double x;
  final double y;
  final double size;
  final double lean;

  const GardenSlot(this.x, this.y, this.size, this.lean);
}

class GardenLayout {
  static const int slotsPerBed = 20;

  static const List<GardenSlot> slots = [
    GardenSlot(0.50, 0.60, 52, 8),
    GardenSlot(0.30, 0.52, 50, -10),
    GardenSlot(0.70, 0.54, 50, 10),
    GardenSlot(0.50, 0.42, 48, -6),
    GardenSlot(0.18, 0.68, 50, -12),
    GardenSlot(0.82, 0.70, 50, 12),
    GardenSlot(0.36, 0.74, 48, 8),
    GardenSlot(0.64, 0.72, 48, -8),
    GardenSlot(0.16, 0.46, 48, -10),
    GardenSlot(0.84, 0.48, 48, 10),
    GardenSlot(0.34, 0.34, 46, 6),
    GardenSlot(0.66, 0.36, 46, -6),
    GardenSlot(0.50, 0.80, 50, 0),
    GardenSlot(0.10, 0.58, 46, -8),
    GardenSlot(0.90, 0.60, 46, 8),
    GardenSlot(0.50, 0.26, 44, 4),
    GardenSlot(0.24, 0.82, 48, -10),
    GardenSlot(0.76, 0.84, 48, 10),
    GardenSlot(0.22, 0.28, 44, -6),
    GardenSlot(0.78, 0.30, 44, 6),
  ];

  static GardenSlot slotAt(int slotIndex) => slots[slotIndex % slotsPerBed];

  static ({int bedIndex, int slotIndex}) nextFreePlacement(
    Iterable<({int bedIndex, int slotIndex})> occupied,
  ) {
    final taken = {
      for (final item in occupied) '${item.bedIndex}-${item.slotIndex}',
    };
    for (var bedIndex = 0; bedIndex < 1000; bedIndex++) {
      for (var slotIndex = 0; slotIndex < slotsPerBed; slotIndex++) {
        if (!taken.contains('$bedIndex-$slotIndex')) {
          return (bedIndex: bedIndex, slotIndex: slotIndex);
        }
      }
    }
    return (bedIndex: 0, slotIndex: 0);
  }
}
