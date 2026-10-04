class BadgeItem {
  final String id;
  final String title;
  final String description;
  final String iconEmoji;
  final bool isUnlocked;
  final double progress; // 0.0 to 1.0

  const BadgeItem({
    required this.id,
    required this.title,
    required this.description,
    required this.iconEmoji,
    required this.isUnlocked,
    required this.progress,
  });
}
