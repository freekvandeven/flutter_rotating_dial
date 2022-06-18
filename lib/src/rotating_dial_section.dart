part of rotating_dial_widget;

class RotatingDialSection {

  RotatingDialSection({
    required this.label,
    required this.value,
    required this.ringPercentage,
    required this.ringColor,
  });
  String label;
  String value;
  double ringPercentage; // 0.0 to 1.0
  Color ringColor;
}
