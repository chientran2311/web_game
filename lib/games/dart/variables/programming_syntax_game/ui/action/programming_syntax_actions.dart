// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:js' as js;
import 'package:web_game/models/dart/variables/programming_syntax_game/entity/syntax_block.dart';
import 'package:web_game/models/dart/variables/programming_syntax_game/enums/programming_syntax_enums.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/state/programming_syntax_state.dart';
import 'package:web_game/games/dart/variables/programming_syntax_game/providers/programming_syntax_provider.dart';

void injectAudioJs() {
  if (!kIsWeb) return;
  try {
    js.context.callMethod('eval', [
      '''
      (function() {
        if (window.playSynthSound) return;
        let audioCtx = null;
        let ambientOsc1 = null;
        let ambientOsc2 = null;
        let ambientGain = null;

        function initAudio() {
          if (!audioCtx) {
            audioCtx = new (window.AudioContext || window.webkitAudioContext)();
          }
        }

        window.playSynthSound = function(freqs, durations, type, volume) {
          try {
            initAudio();
            let time = audioCtx.currentTime;
            for (let i = 0; i < freqs.length; i++) {
              let freq = freqs[i];
              let duration = durations[i];
              let osc = audioCtx.createOscillator();
              let gainNode = audioCtx.createGain();
              
              osc.type = type || 'sine';
              osc.frequency.setValueAtTime(freq, time);
              
              gainNode.gain.setValueAtTime(volume || 0.1, time);
              gainNode.gain.exponentialRampToValueAtTime(0.0001, time + duration);
              
              osc.connect(gainNode);
              gainNode.connect(audioCtx.destination);
              
              osc.start(time);
              osc.stop(time + duration);
              
              time += duration * 0.4;
            }
          } catch(e) {
            console.error("Audio synth error:", e);
          }
        };

        window.startAmbientSynth = function() {
          try {
            initAudio();
            if (ambientOsc1) return;
            
            ambientOsc1 = audioCtx.createOscillator();
            ambientOsc2 = audioCtx.createOscillator();
            ambientGain = audioCtx.createGain();
            
            ambientOsc1.type = 'sine';
            ambientOsc1.frequency.setValueAtTime(55, audioCtx.currentTime);
            
            ambientOsc2.type = 'triangle';
            ambientOsc2.frequency.setValueAtTime(110, audioCtx.currentTime);
            
            ambientGain.gain.setValueAtTime(0.03, audioCtx.currentTime);
            
            ambientOsc1.connect(ambientGain);
            ambientOsc2.connect(ambientGain);
            ambientGain.connect(audioCtx.destination);
            
            ambientOsc1.start();
            ambientOsc2.start();
          } catch(e) {
            console.error("Ambient audio error:", e);
          }
        };

        window.stopAmbientSynth = function() {
          try {
            if (ambientOsc1) {
              ambientOsc1.stop();
              ambientOsc1 = null;
            }
            if (ambientOsc2) {
              ambientOsc2.stop();
              ambientOsc2 = null;
            }
          } catch(e) {
            console.error("Ambient audio stop error:", e);
          }
        };
      })();
      '''
    ]);
  } catch (e) {
    debugPrint("Failed to inject JS audio synthesizer: $e");
  }
}

class ProgrammingSyntaxActions {
  final WidgetRef ref;

  ProgrammingSyntaxActions(this.ref) {
    injectAudioJs();
  }

  ProgrammingSyntaxState get state => ref.read(programmingSyntaxGameNotifierProvider);
  ProgrammingSyntaxGameNotifier get notifier => ref.read(programmingSyntaxGameNotifierProvider.notifier);

  void playClick() {
    if (state.isSoundEnabled && kIsWeb) {
      try {
        js.context.callMethod('playSynthSound', [
          js.JsArray.from([800]),
          js.JsArray.from([0.05]),
          'sine',
          0.08
        ]);
      } catch (e) {
        debugPrint("Play sound error: $e");
      }
    }
  }

  void playSuccess() {
    if (state.isSoundEnabled && kIsWeb) {
      try {
        js.context.callMethod('playSynthSound', [
          js.JsArray.from([261.63, 329.63, 392.00, 523.25]),
          js.JsArray.from([0.15, 0.15, 0.15, 0.3]),
          'triangle',
          0.15
        ]);
      } catch (e) {
        debugPrint("Play sound error: $e");
      }
    }
  }

  void playFail() {
    if (state.isSoundEnabled && kIsWeb) {
      try {
        js.context.callMethod('playSynthSound', [
          js.JsArray.from([150, 100]),
          js.JsArray.from([0.2, 0.4]),
          'sawtooth',
          0.2
        ]);
      } catch (e) {
        debugPrint("Play sound error: $e");
      }
    }
  }

  void handleSelectBlock(SyntaxBlock block) {
    playClick();
    notifier.selectBlock(block);
  }

  void handleRemoveBlock(int slotIndex) {
    playClick();
    notifier.removeBlock(slotIndex);
  }

  void handlePlaceBlockAt(SyntaxBlock block, int slotIndex) {
    playClick();
    notifier.placeBlockAt(block, slotIndex);
  }

  void handleUpdateCustomValue(int slotIndex, String value) {
    notifier.updateCustomValue(slotIndex, value);
  }

  void handleFilterInventory(InventoryFilter filter) {
    playClick();
    notifier.filterInventory(filter);
  }

  void handleToggleHelp(bool visible) {
    playClick();
    notifier.toggleHelp(visible);
  }

  void handleResetCurrentLevel() {
    playClick();
    notifier.resetCurrentLevel();
  }

  void handleVerifySyntax(VoidCallback? onShake) {
    final isSuccess = notifier.verifySyntax();
    if (isSuccess) {
      playSuccess();
    } else {
      playFail();
      if (onShake != null) {
        onShake();
      }
    }
  }

  void handleGoToNextLevel() {
    playClick();
    notifier.goToNextLevel();
  }

  void handleChangeFont(String fontName) {
    playClick();
    notifier.changeFont(fontName);
  }

  void handleToggleSound(bool enabled) {
    notifier.toggleSound(enabled);
  }

  void handleToggleAmbient(bool enabled) {
    notifier.toggleAmbient(enabled);
    if (enabled) {
      if (kIsWeb) {
        try {
          js.context.callMethod('startAmbientSynth', []);
        } catch (e) {
          debugPrint("Play sound error: $e");
        }
      }
    } else {
      if (kIsWeb) {
        try {
          js.context.callMethod('stopAmbientSynth', []);
        } catch (e) {
          debugPrint("Play sound error: $e");
        }
      }
    }
  }

  void handleToggleGrid(bool enabled) {
    playClick();
    notifier.toggleGrid(enabled);
  }

  void handleToggleTweaks() {
    notifier.toggleTweaks();
  }
}
