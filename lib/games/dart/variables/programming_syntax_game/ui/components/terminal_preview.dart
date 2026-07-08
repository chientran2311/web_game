import 'package:flutter/material.dart';
import 'package:web_game/core/utils/logger.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/entity/syntax_block.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/enums/programming_syntax_enums.dart';

class TerminalPreview extends StatelessWidget {
  final List<SyntaxBlock?> slotPlacements;
  final String terminalOutput;
  final bool isTerminalError;

  const TerminalPreview({
    super.key,
    required this.slotPlacements,
    required this.terminalOutput,
    required this.isTerminalError,
  });

  Color getNeonColor(BlockColor color) {
    switch (color) {
      case BlockColor.orange:
        return const Color(0xFFFF7E40);
      case BlockColor.cyan:
        return const Color(0xFF00F2FE);
      case BlockColor.yellow:
        return const Color(0xFFFFE040);
      case BlockColor.purple:
        return const Color(0xFFBD10E0);
      case BlockColor.green:
        return const Color(0xFF00FF66);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reconstruct code chain from placements
    final List<TextSpan> previewSpans = [];
    for (int i = 0; i < slotPlacements.length; i++) {
      final placed = slotPlacements[i];
      if (placed != null) {
        String text = placed.text;
        if (placed.isCustom) {
          final customValue = placed.customValue;
          if (customValue != null && customValue.isNotEmpty) {
            text = customValue;
          } else {
            AppLogger.v("TerminalPreview: customValue at slot index $i is null or empty");
            text = '___';
          }
        }
        previewSpans.add(
          TextSpan(
            text: '$text ',
            style: TextStyle(
              color: getNeonColor(placed.color),
              shadows: [
                Shadow(
                  color: getNeonColor(placed.color).withValues(alpha: 0.5),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
        );
      } else {
        previewSpans.add(
          TextSpan(
            text: '... ',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF050712).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Terminal Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildDot(const Color(0xFFFF7E40)),
                  const SizedBox(width: 6),
                  _buildDot(const Color(0xFFFFE040)),
                  const SizedBox(width: 6),
                  _buildDot(const Color(0xFF00FF66)),
                ],
              ),
              const Text(
                'LIVE SYNTAX PREVIEW',
                style: TextStyle(
                  fontFamily: 'FiraCode',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF90A4AE),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Code Preview Block
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'FiraCode',
                  fontSize: 18,
                  height: 1.4,
                ),
                children: previewSpans,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Console Log Output
          Container(
            constraints: const BoxConstraints(minHeight: 60, maxHeight: 110),
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Text(
                terminalOutput,
                style: TextStyle(
                  fontFamily: 'FiraCode',
                  fontSize: 13,
                  height: 1.6,
                  color: isTerminalError
                      ? const Color(0xFFFF7E40) // neon error red/orange
                      : const Color(0xFF00FF66), // neon success green
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
