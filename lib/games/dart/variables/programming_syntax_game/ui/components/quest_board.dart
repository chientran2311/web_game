import 'package:flutter/material.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/ui/components/slot_widget.dart'; // for DashedBorderPainter

class QuestBoard extends StatelessWidget {
  final int currentLevel;
  final int maxLevels;
  final int score;
  final String questHtml;

  const QuestBoard({
    super.key,
    required this.currentLevel,
    required this.maxLevels,
    required this.score,
    required this.questHtml,
  });

  Widget _parseQuestText(String htmlText) {
    final spans = <InlineSpan>[];
    // Simple regex to match <code>...</code>
    final regex = RegExp(r'<code>(.*?)</code>');
    int lastMatchEnd = 0;

    for (final match in regex.allMatches(htmlText)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: htmlText.substring(lastMatchEnd, match.start),
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 15,
            height: 1.5,
            color: Color(0xFFECEFF1),
          ),
        ));
      }
      final codeContent = match.group(1) ?? '';
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Text(
            codeContent,
            style: const TextStyle(
              fontFamily: 'FiraCode',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFE040), // Neon Yellow for code keywords
            ),
          ),
        ),
      ));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < htmlText.length) {
      spans.add(TextSpan(
        text: htmlText.substring(lastMatchEnd),
        style: const TextStyle(
          fontFamily: 'Outfit',
          fontSize: 15,
          height: 1.5,
          color: Color(0xFFECEFF1),
        ),
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161A2F).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row: Brand & Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo & Title
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00F2FE), Color(0xFFBD10E0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00F2FE).withValues(alpha: 0.5),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '</>',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'SYNTAX QUEST',
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Stats
              Row(
                children: [
                  _buildStatBadge('MÀN', '$currentLevel/$maxLevels'),
                  const SizedBox(width: 10),
                  _buildStatBadge('ĐIỂM', '$score'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Quest Card with dashed cyan border
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF00F2FE).withValues(alpha: 0.02),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomPaint(
                  painter: DashedBorderPainter(
                    color: const Color(0xFF00F2FE).withValues(alpha: 0.7),
                    strokeWidth: 1.0,
                    radius: 10,
                    dashWidth: 4,
                    dashSpace: 4,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.grid_view_rounded,
                              size: 14,
                              color: const Color(0xFF00F2FE),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'MỤC TIÊU CÚ PHÁP',
                              style: TextStyle(
                                fontFamily: 'SpaceGrotesk',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                color: Color(0xFF00F2FE),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _parseQuestText(questHtml),
                      ],
                    ),
                  ),
                ),
              ),
              // Cyber Quest Tag Badge
              Positioned(
                top: 0,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00F2FE),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00F2FE).withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Text(
                    'NHIỆM VỤ',
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBadge(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
            fontFamily: 'FiraCode',
            fontSize: 12,
            color: Color(0xFF90A4AE),
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontFamily: 'FiraCode',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00F2FE),
                shadows: [
                  Shadow(
                    color: Color(0xFF00F2FE),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
