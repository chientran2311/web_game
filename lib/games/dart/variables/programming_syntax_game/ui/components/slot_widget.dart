import 'package:flutter/material.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/entity/syntax_block.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/enums/programming_syntax_enums.dart';
import 'block_widget.dart';

class SlotWidget extends StatefulWidget {
  final int index;
  final String label;
  final SyntaxBlock? block;
  final ValueChanged<SyntaxBlock> onBlockDropped;
  final VoidCallback onBlockRemoved;
  final ValueChanged<String>? onInputChanged;

  const SlotWidget({
    super.key,
    required this.index,
    required this.label,
    this.block,
    required this.onBlockDropped,
    required this.onBlockRemoved,
    this.onInputChanged,
  });

  @override
  State<SlotWidget> createState() => _SlotWidgetState();
}

class _SlotWidgetState extends State<SlotWidget> {
  bool _isDragOver = false;

  @override
  Widget build(BuildContext context) {
    // Map index to expected BlockType to keep layout matching clean and minimal
    BlockType? allowedType;
    switch (widget.index) {
      case 0:
        allowedType = BlockType.keyword;
        break;
      case 1:
        allowedType = BlockType.type;
        break;
      case 2:
        allowedType = BlockType.name;
        break;
      case 3:
        allowedType = BlockType.operator;
        break;
      case 4:
        allowedType = BlockType.value;
        break;
      case 5:
        allowedType = BlockType.operator;
        break;
    }

    final borderCol = _isDragOver
        ? const Color(0xFF00F2FE)
        : Colors.white.withValues(alpha: 0.15);
    final bgCol = _isDragOver
        ? const Color(0xFF00F2FE).withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.01);
    final glow = _isDragOver
        ? [
            BoxShadow(
              color: const Color(0xFF00F2FE).withValues(alpha: 0.2),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ]
        : <BoxShadow>[];

    return DragTarget<SyntaxBlock>(
      onWillAcceptWithDetails: (details) {
        if (allowedType != null) {
          return details.data.type == allowedType;
        }
        return true;
      },
      onAcceptWithDetails: (details) {
        widget.onBlockDropped(details.data);
        setState(() {
          _isDragOver = false;
        });
      },
      onLeave: (data) {
        setState(() {
          _isDragOver = false;
        });
      },
      onMove: (details) {
        if (!_isDragOver) {
          setState(() {
            _isDragOver = true;
          });
        }
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 64,
          decoration: BoxDecoration(
            color: bgCol,
            borderRadius: BorderRadius.circular(8),
            boxShadow: glow,
          ),
          child: CustomPaint(
            painter: DashedBorderPainter(
              color: borderCol,
              strokeWidth: _isDragOver ? 2.0 : 1.0,
              radius: 8.0,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Render placed block or empty slot label
                Center(
                  child: () {
                    final block = widget.block;
                    if (block != null) {
                      return FractionallySizedBox(
                        widthFactor: 0.9,
                        heightFactor: 0.8,
                        child: BlockWidget(
                          block: block,
                          inSlot: true,
                          onTap: widget.onBlockRemoved,
                          onInputChanged: widget.onInputChanged,
                        ),
                      );
                    } else {
                      return Text(
                        '',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.2),
                          fontSize: 12,
                        ),
                      );
                    }
                  }(),
                ),
                // Slot description label positioned below slot
                Positioned(
                  bottom: -22,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: widget.block != null
                            ? Colors.white.withValues(alpha: 0.5)
                            : Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Dashed border helper
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
    this.dashWidth = 6.0,
    this.dashSpace = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    // Draw dashed path
    final dashPath = Path();
    double distance = 0.0;
    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final length = dashWidth;
        if (distance + length < pathMetric.length) {
          dashPath.addPath(
            pathMetric.extractPath(distance, distance + length),
            Offset.zero,
          );
        } else {
          dashPath.addPath(
            pathMetric.extractPath(distance, pathMetric.length),
            Offset.zero,
          );
        }
        distance += length + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
