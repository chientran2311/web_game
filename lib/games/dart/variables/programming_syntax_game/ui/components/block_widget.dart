import 'package:flutter/material.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/entity/syntax_block.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/enums/programming_syntax_enums.dart';

class BlockWidget extends StatefulWidget {
  final SyntaxBlock block;
  final bool inSlot;
  final VoidCallback? onTap;
  final ValueChanged<String>? onInputChanged;

  const BlockWidget({
    super.key,
    required this.block,
    this.inSlot = false,
    this.onTap,
    this.onInputChanged,
  });

  @override
  State<BlockWidget> createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.block.customValue ?? '');
  }

  @override
  void didUpdateWidget(covariant BlockWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.block.customValue != widget.block.customValue &&
        _controller.text != widget.block.customValue) {
      _controller.text = widget.block.customValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  List<Color> getGradients(BlockColor color) {
    final base = getNeonColor(color);
    switch (color) {
      case BlockColor.orange:
        return [base, const Color(0xFFD35400)];
      case BlockColor.cyan:
        return [base, const Color(0xFF0097A7)];
      case BlockColor.yellow:
        return [base, const Color(0xFFF39C12)];
      case BlockColor.purple:
        return [base, const Color(0xFF8E44AD)];
      case BlockColor.green:
        return [base, const Color(0xFF27AE60)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getNeonColor(widget.block.color);
    final gradients = getGradients(widget.block.color);
    final isDarkText = widget.block.color != BlockColor.purple;

    Widget child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradients,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.15),
            offset: const Offset(0, 1),
            blurRadius: 0,
            spreadRadius: 0,
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: widget.block.isCustom && widget.inSlot
          ? Center(
              child: SizedBox(
                width: 100,
                height: 30,
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'FiraCode',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nhập tên...',
                    hintStyle: TextStyle(
                      fontFamily: 'FiraCode',
                      fontSize: 11,
                      color: color.withValues(alpha: 0.5),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: 12),
                    fillColor: Colors.black.withValues(alpha: 0.5),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: color),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: color, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: color.withValues(alpha: 0.7)),
                    ),
                  ),
                  onChanged: widget.onInputChanged,
                ),
              ),
            )
          : Text(
              widget.block.text,
              style: TextStyle(
                fontFamily: 'FiraCode',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDarkText ? Colors.black : Colors.white,
              ),
            ),
    );

    // Draggable feedback widget (shown under finger when dragging)
    Widget feedback = Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 120,
        height: 48,
        child: child,
      ),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.grab,
      child: GestureDetector(
        onTap: widget.onTap,
        child: widget.inSlot
            ? child
            : Draggable<SyntaxBlock>(
                data: widget.block,
                feedback: feedback,
                childWhenDragging: Opacity(
                  opacity: 0.3,
                  child: child,
                ),
                child: child,
              ),
      ),
    );
  }
}
