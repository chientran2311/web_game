import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/providers/programming_syntax_provider.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/ui/action/programming_syntax_actions.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/ui/events/programming_syntax_levels.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/ui/components/quest_board.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/ui/components/slot_widget.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/ui/components/terminal_preview.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/ui/components/inventory_dock.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/ui/components/tweaks_overlay.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/ui/components/help_overlay.dart';

class ProgrammingSyntaxGamePage extends ConsumerStatefulWidget {
  const ProgrammingSyntaxGamePage({super.key});

  @override
  ConsumerState<ProgrammingSyntaxGamePage> createState() =>
      _ProgrammingSyntaxGamePageState();
}

class _ProgrammingSyntaxGamePageState
    extends ConsumerState<ProgrammingSyntaxGamePage>
    with TickerProviderStateMixin {
  late ProgrammingSyntaxActions _actions;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  late AnimationController _celebrationController;
  final List<Particle> _particles = [];
  final GlobalKey _slotsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _actions = ProgrammingSyntaxActions(ref);

    // Shake animation
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));

    // Particle success celebration animation
    _celebrationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..addListener(() {
        if (_celebrationController.isAnimating) {
          _updateParticles();
        }
      });

    // Auto open guide modal on start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _actions.handleToggleHelp(true);
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  void _triggerShake() {
    _shakeController.forward(from: 0.0);
  }

  void _triggerSuccessCelebration() {
    _particles.clear();
    final random = math.Random();
    
    // Attempt to locate position of slots container
    double startX = MediaQuery.sizeOf(context).width / 2;
    double startY = MediaQuery.sizeOf(context).height / 2;

    try {
      final renderBox = _slotsKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final position = renderBox.localToGlobal(Offset.zero);
        final size = renderBox.size;
        startX = position.dx + size.width / 2;
        startY = position.dy + size.height / 2;
      }
    } catch (_) {}

    final colors = [
      const Color(0xFFFF7E40), // Orange
      const Color(0xFF00F2FE), // Cyan
      const Color(0xFFFFE040), // Yellow
      const Color(0xFFBD10E0), // Purple
      const Color(0xFF00FF66), // Green
    ];

    for (int i = 0; i < 80; i++) {
      _particles.add(
        Particle(
          x: startX,
          y: startY,
          vx: (random.nextDouble() * 12) - 6,
          vy: -(random.nextDouble() * 15) - 5,
          color: colors[random.nextInt(colors.length)],
          size: random.nextDouble() * 4 + 2,
        ),
      );
    }
    _celebrationController.forward(from: 0.0);
  }

  void _updateParticles() {
    setState(() {
      for (final p in _particles) {
        p.vy += 0.3; // Gravity
        p.x += p.vx;
        p.y += p.vy;
        p.alpha -= 0.015;
      }
      _particles.removeWhere((p) => p.alpha <= 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(programmingSyntaxGameNotifierProvider);
    final width = MediaQuery.sizeOf(context).width;

    if (width <= 0) {
      return const Scaffold(
        backgroundColor: Color(0xFF0C0E1A),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentLevelData = gameLevels.firstWhere(
      (l) => l.level == state.currentLevel,
      orElse: () => gameLevels.first,
    );

    // Apply font family dynamic changes
    ThemeData customTheme = Theme.of(context);
    if (state.fontFamily == 'SpaceGrotesk') {
      customTheme = customTheme.copyWith(
        textTheme: customTheme.textTheme.apply(fontFamily: 'SpaceGrotesk'),
      );
    } else if (state.fontFamily == 'FiraCode') {
      customTheme = customTheme.copyWith(
        textTheme: customTheme.textTheme.apply(fontFamily: 'FiraCode'),
      );
    } else {
      customTheme = customTheme.copyWith(
        textTheme: customTheme.textTheme.apply(fontFamily: 'Outfit'),
      );
    }

    return Theme(
      data: customTheme,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0C0E1A),
          ),
          child: Stack(
            children: [
              // Custom grid painter fallback
              if (state.isGridEnabled)
                Positioned.fill(
                  child: CustomPaint(
                    painter: GridBackgroundPainter(),
                  ),
                ),
              // Main Scrollable Area
              Positioned.fill(
                child: SafeArea(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 900),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Back Button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: () {
                                  // Back to Dashboard
                                  context.go('/');
                                },
                                icon: const Icon(Icons.arrow_back, color: Color(0xFF00F2FE)),
                                label: const Text(
                                  'QUAY LẠI',
                                  style: TextStyle(
                                    fontFamily: 'SpaceGrotesk',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00F2FE),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Area 1: Quest & Info
                            QuestBoard(
                              currentLevel: state.currentLevel,
                              maxLevels: state.maxLevels,
                              score: state.score,
                              questHtml: currentLevelData.quest,
                            ),
                            const SizedBox(height: 20),
                            // Area 2 & 3: Syntax Assembly (With shake animation container)
                            AnimatedBuilder(
                              animation: _shakeAnimation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(_shakeAnimation.value, 0),
                                  child: child,
                                );
                              },
                              child: Container(
                                key: _slotsKey,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF161A2F).withValues(alpha: 0.4),
                                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'KHAY LẮP GHÉP CÚ PHÁP (SYNTAX ASSEMBLY SLOT)',
                                          style: TextStyle(
                                            fontFamily: 'SpaceGrotesk',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                            color: Color(0xFF90A4AE),
                                          ),
                                        ),
                                        if (width > 600)
                                          const Text(
                                            'Kéo thả khối vào đây hoặc nhấp khối ở dưới',
                                            style: TextStyle(
                                              fontFamily: 'Outfit',
                                              fontSize: 10,
                                              color: Color(0xFF546E7A),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    // Assembly slots grid
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: width > 768 ? 6 : 3,
                                        childAspectRatio: 2.2 / 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 25, // extra space below for labels
                                      ),
                                      itemCount: 6,
                                      itemBuilder: (context, idx) {
                                        final labels = [
                                          'Từ khóa',
                                          'Kiểu dữ liệu',
                                          'Tên biến',
                                          'Gán',
                                          'Giá trị',
                                          'Kết thúc'
                                        ];
                                        return SlotWidget(
                                          index: idx,
                                          label: labels[idx],
                                          block: state.slotPlacements[idx],
                                          onBlockDropped: (block) {
                                            _actions.handlePlaceBlockAt(block, idx);
                                          },
                                          onBlockRemoved: () {
                                            _actions.handleRemoveBlock(idx);
                                          },
                                          onInputChanged: (val) {
                                            _actions.handleUpdateCustomValue(idx, val);
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Interactive live compile console
                            TerminalPreview(
                              slotPlacements: state.slotPlacements,
                              terminalOutput: state.terminalOutput,
                              isTerminalError: state.isTerminalError,
                            ),
                            const SizedBox(height: 20),
                            // Action controllers row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () => _actions.handleToggleHelp(true),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
                                    ),
                                  ),
                                  child: const Text('HƯỚNG DẪN'),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: _actions.handleResetCurrentLevel,
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                      ),
                                      child: const Text('LÀM MỚI'),
                                    ),
                                    const SizedBox(width: 10),
                                    if (!state.isSuccessCompleted)
                                      ElevatedButton(
                                        onPressed: () => _actions.handleVerifySyntax(_triggerShake),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: const Color(0xFF00F2FE),
                                          shadowColor: const Color(0xFF00F2FE).withValues(alpha: 0.5),
                                          elevation: 10,
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          'KIỂM TRA CÚ PHÁP',
                                          style: TextStyle(
                                            fontFamily: 'SpaceGrotesk',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    else
                                      ElevatedButton(
                                        onPressed: () {
                                          _actions.handleGoToNextLevel();
                                          if (state.currentLevel == state.maxLevels) {
                                            _triggerSuccessCelebration();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          backgroundColor: const Color(0xFF00FF66),
                                          shadowColor: const Color(0xFF00FF66).withValues(alpha: 0.5),
                                          elevation: 10,
                                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text(
                                          state.currentLevel < state.maxLevels
                                              ? 'MÀN TIẾP THEO'
                                              : 'HOÀN THÀNH',
                                          style: const TextStyle(
                                            fontFamily: 'SpaceGrotesk',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Area 4: Inventory Dock (Keyword blocks selection grid)
                            InventoryDock(
                              allBlocks: state.inventoryBlocks,
                              currentFilter: state.currentFilter,
                              onFilterChanged: _actions.handleFilterInventory,
                              onBlockSelected: _actions.handleSelectBlock,
                            ),
                            const SizedBox(height: 80), // spacer for bottom floating menu
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Success celebration particles custom paint overlay
              if (_celebrationController.isAnimating)
                IgnorePointer(
                  child: CustomPaint(
                    painter: ParticlePainter(_particles),
                    child: Container(),
                  ),
                ),
              // Area 5: Tweaks float settings panel
              TweaksOverlay(
                isOpen: state.isTweakOpen,
                fontFamily: state.fontFamily,
                soundEnabled: state.isSoundEnabled,
                ambientEnabled: state.isAmbientPlaying,
                gridEnabled: state.isGridEnabled,
                onToggleOpen: _actions.handleToggleTweaks,
                onFontChanged: _actions.handleChangeFont,
                onSoundToggled: _actions.handleToggleSound,
                onAmbientToggled: _actions.handleToggleAmbient,
                onGridToggled: _actions.handleToggleGrid,
              ),
              // Guide instruction overlay dialog
              if (state.showHelpOverlay)
                HelpOverlay(
                  onClose: () => _actions.handleToggleHelp(false),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Particle helper model
class Particle {
  double x;
  double y;
  double vx;
  double vy;
  Color color;
  double size;
  double alpha = 1.0;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    required this.size,
  });
}

// Particles painter for success celebration
class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final paint = Paint()
        ..color = p.color.withValues(alpha: p.alpha)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(p.x, p.y), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}

// Cyber grid background painter
class GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1D4ED8).withValues(alpha: 0.04)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double gridSize = 40.0;
    
    // Draw vertical lines
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    
    // Draw horizontal lines
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant GridBackgroundPainter oldDelegate) => false;
}
