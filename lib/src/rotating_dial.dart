part of rotating_dial_widget;

class RotatingDialWidget extends StatefulWidget {
  const RotatingDialWidget({
    required this.sections,
    this.title = 'Average',
    this.titleColor = const Color(0xFF000000),
    this.dialColor = const Color(0xFF1164e9),
    this.markerColor = const Color(0xFFffca5c),
    this.textColor = const Color(0xFFffffff),
    Key? key,
  }) : super(key: key);

  final String title;
  final Color titleColor;
  final List<RotatingDialSection> sections;
  final Color textColor;
  final Color dialColor;
  final Color markerColor;

  @override
  State<RotatingDialWidget> createState() => _RotatingDialWidgetState();
}

class _RotatingDialWidgetState extends State<RotatingDialWidget> {
  String currentSelectedText = '3:00:00';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.titleColor,
                  ),
                ),
                Text(
                  currentSelectedText,
                  style: TextStyle(
                    color: widget.titleColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox.expand(
          child: CustomPaint(
            painter: DialPainter(
              ringColor: widget.dialColor,
              markerColor: widget.markerColor,
            ),
          ),
        ),
      ],
    );
  }
}

class RingPainter extends CustomPainter {
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {}
}

class DialPainter extends CustomPainter {
  DialPainter({
    required this.ringColor,
    required this.markerColor,
  });
  Color ringColor;
  Color markerColor;
  List<RotatingDialSection> sections = [];

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    var ringWidth = size.width / 5;
    var paint = Paint()
      ..color = ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - ringWidth / 2,
      paint,
    );

    var markerPosition = Offset(
      size.width / 2,
      size.height,
    );
    var markerPaint = Paint()
      ..color = markerColor
      ..style = PaintingStyle.fill;
    var markerSize = size.width / 24;
    var adjustedMarkerPosition =
        Offset(markerPosition.dx, markerPosition.dy + markerSize / 2 - 3);
    canvas.drawCircle(
      adjustedMarkerPosition,
      // TODO(freek): remove the offset of 3 to something dynamic
      markerSize,
      markerPaint,
    );

    // adjust markerPosition by x pixels
    var path = Path()
      ..moveTo(markerPosition.dx - markerSize, markerPosition.dy)
      ..lineTo(markerPosition.dx, markerPosition.dy - markerSize * 1.5)
      ..lineTo(markerPosition.dx + markerSize, markerPosition.dy)
      ..close();
    canvas.drawPath(path, markerPaint);
    var innerCirclePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      adjustedMarkerPosition,
      markerSize / 2.1,
      innerCirclePaint,
    );

    
  }
}

class MarkerPainter extends CustomPainter {
  MarkerPainter({
    required this.markerColor,
    required this.degrees,
  });

  Color markerColor;
  double degrees;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    var markerWidth = size.width / 20;
    var paint = Paint()
      ..color = markerColor
      ..style = PaintingStyle.fill;
    // calculate markerCenter along the circle arc based on degrees
    var markerCenter = Offset(
      size.width / 2 +
          (size.width / 2 - markerWidth) * cos((degrees - 90) * pi / 180),
      size.height / 2 +
          (size.height / 2 - markerWidth) * sin((degrees - 90) * pi / 180),
    );
    // var markerCenter = Offset(
    //   size.width / 2 + (size.width / 2) * sin(degrees / 360.0 * pi),
    //   size.height / 2 +
    //       (size.height / 2) * cos(degrees / 360.0 * pi),
    // );

    canvas.drawCircle(markerCenter, markerWidth, paint);
  }
}
