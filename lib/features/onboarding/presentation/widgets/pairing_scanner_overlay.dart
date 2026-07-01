import 'package:flutter/material.dart';

class PairingScannerOverlay extends StatelessWidget {
  final bool isSuccess;
  const PairingScannerOverlay({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scanAreaSize = MediaQuery.of(context).size.width * 0.7;

    return Stack(
      children: [
        Center(
          child: Container(
            width: scanAreaSize,
            height: scanAreaSize,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: isSuccess
                    ? Colors.green
                    : Colors.white.withValues(alpha: 0.2),
                width: 4.0,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: scanAreaSize,
            height: scanAreaSize,
            child: CustomPaint(
              painter: _ScannerBorderPainter(
                color: isSuccess ? Colors.green : theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScannerBorderPainter extends CustomPainter {
  final Color color;
  _ScannerBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    const cornerSize = 40.0;
    final path = Path();

    path.moveTo(0, cornerSize);
    path.lineTo(0, 0);
    path.lineTo(cornerSize, 0);
    path.moveTo(size.width - cornerSize, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, cornerSize);
    path.moveTo(size.width, size.height - cornerSize);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - cornerSize, size.height);
    path.moveTo(cornerSize, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height - cornerSize);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
