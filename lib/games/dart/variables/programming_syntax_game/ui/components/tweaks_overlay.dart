import 'package:flutter/material.dart';

class TweaksOverlay extends StatelessWidget {
  final bool isOpen;
  final String fontFamily;
  final bool soundEnabled;
  final bool ambientEnabled;
  final bool gridEnabled;
  final VoidCallback onToggleOpen;
  final ValueChanged<String> onFontChanged;
  final ValueChanged<bool> onSoundToggled;
  final ValueChanged<bool> onAmbientToggled;
  final ValueChanged<bool> onGridToggled;

  const TweaksOverlay({
    super.key,
    required this.isOpen,
    required this.fontFamily,
    required this.soundEnabled,
    required this.ambientEnabled,
    required this.gridEnabled,
    required this.onToggleOpen,
    required this.onFontChanged,
    required this.onSoundToggled,
    required this.onAmbientToggled,
    required this.onGridToggled,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      bottom: 20,
      right: 20,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: const Color(0xFF0C0E19).withValues(alpha: 0.95),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 40,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Panel Header (clickable to collapse/expand)
            InkWell(
              onTap: onToggleOpen,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '🎮 BẢNG TÙY BIẾN GAME',
                      style: TextStyle(
                        fontFamily: 'SpaceGrotesk',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00F2FE),
                      ),
                    ),
                    Text(
                      isOpen ? '▼' : '▲',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF00F2FE),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isOpen) ...[
              const Divider(color: Colors.white24, height: 1),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    // Font Selection
                    _buildSettingRow(
                      label: 'Font Chữ:',
                      child: Container(
                        height: 28,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: fontFamily,
                            dropdownColor: const Color(0xFF0C0E19),
                            style: const TextStyle(
                              fontFamily: 'FiraCode',
                              fontSize: 11,
                              color: Colors.white,
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 16,
                              color: Colors.white54,
                            ),
                            items: const [
                              DropdownMenuItem(value: 'Outfit', child: Text('Outfit')),
                              DropdownMenuItem(value: 'SpaceGrotesk', child: Text('Space G.')),
                              DropdownMenuItem(value: 'FiraCode', child: Text('Fira Code')),
                            ],
                            onChanged: (val) {
                              if (val != null) onFontChanged(val);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Sound effects
                    _buildSettingRow(
                      label: 'Âm thanh:',
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: soundEnabled,
                          activeColor: const Color(0xFF00F2FE),
                          checkColor: Colors.black,
                          side: const BorderSide(color: Colors.white30),
                          onChanged: (val) {
                            if (val != null) onSoundToggled(val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Ambient Music
                    _buildSettingRow(
                      label: 'Nhạc nền (Synth):',
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: ambientEnabled,
                          activeColor: const Color(0xFF00F2FE),
                          checkColor: Colors.black,
                          side: const BorderSide(color: Colors.white30),
                          onChanged: (val) {
                            if (val != null) onAmbientToggled(val);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Display Grid
                    _buildSettingRow(
                      label: 'Hiển thị lưới:',
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: gridEnabled,
                          activeColor: const Color(0xFF00F2FE),
                          checkColor: Colors.black,
                          side: const BorderSide(color: Colors.white30),
                          onChanged: (val) {
                            if (val != null) onGridToggled(val);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow({required String label, required Widget child}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 12,
            color: Color(0xFF90A4AE),
          ),
        ),
        child,
      ],
    );
  }
}
