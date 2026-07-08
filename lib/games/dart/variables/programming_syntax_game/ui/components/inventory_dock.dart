import 'package:flutter/material.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/entity/syntax_block.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/enums/programming_syntax_enums.dart';
import 'block_widget.dart';

class InventoryDock extends StatelessWidget {
  final List<SyntaxBlock> allBlocks;
  final InventoryFilter currentFilter;
  final ValueChanged<InventoryFilter> onFilterChanged;
  final ValueChanged<SyntaxBlock> onBlockSelected;

  const InventoryDock({
    super.key,
    required this.allBlocks,
    required this.currentFilter,
    required this.onFilterChanged,
    required this.onBlockSelected,
  });

  bool _matchesFilter(SyntaxBlock block, InventoryFilter filter) {
    if (filter == InventoryFilter.all) return true;
    switch (filter) {
      case InventoryFilter.keyword:
        return block.type == BlockType.keyword;
      case InventoryFilter.type:
        return block.type == BlockType.type;
      case InventoryFilter.name:
        return block.type == BlockType.name;
      case InventoryFilter.value:
        return block.type == BlockType.value;
      case InventoryFilter.operator:
        return block.type == BlockType.operator;
      default:
        return false;
    }
  }

  String _getTabLabel(InventoryFilter filter) {
    switch (filter) {
      case InventoryFilter.all:
        return 'TẤT CẢ';
      case InventoryFilter.keyword:
        return 'Từ Khóa';
      case InventoryFilter.type:
        return 'Kiểu Dữ Liệu';
      case InventoryFilter.name:
        return 'Tên Biến';
      case InventoryFilter.value:
        return 'Giá Trị';
      case InventoryFilter.operator:
        return 'Toán Tử';
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredBlocks = allBlocks
        .where((block) => _matchesFilter(block, currentFilter))
        .toList();

    final width = MediaQuery.sizeOf(context).width;
    // Determine the column count dynamically based on the width to make it responsive
    final crossAxisCount = width > 768 ? 6 : (width > 480 ? 4 : 3);

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
          const Text(
            'KHO NĂNG LƯỢNG TỪ KHÓA (INVENTORY DOCK)',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Color(0xFF90A4AE),
            ),
          ),
          const SizedBox(height: 15),
          // Tabs row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: InventoryFilter.values.map((filter) {
                final isActive = filter == currentFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () => onFilterChanged(filter),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF00F2FE).withValues(alpha: 0.08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isActive
                              ? const Color(0xFF00F2FE)
                              : Colors.transparent,
                        ),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF00F2FE).withValues(alpha: 0.1),
                                  blurRadius: 10,
                                )
                              ]
                            : null,
                      ),
                      child: Text(
                        _getTabLabel(filter),
                        style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 13,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          color: isActive ? Colors.white : const Color(0xFF90A4AE),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 15),
          // Grid
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 2.3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredBlocks.length,
              itemBuilder: (context, idx) {
                final block = filteredBlocks[idx];
                return BlockWidget(
                  block: block,
                  inSlot: false,
                  onTap: () => onBlockSelected(block),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
