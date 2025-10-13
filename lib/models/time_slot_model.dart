class TimeSlotModel {
  final String start;
  final String label;
  final bool isAvailable;

  TimeSlotModel({
    required this.start,
    required this.label,
    this.isAvailable = true,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      start: json['start'] as String,
      label: json['label'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {'start': start, 'label': label, 'isAvailable': isAvailable};
  }

  DateTime get startDateTime => DateTime.parse(start);
}
