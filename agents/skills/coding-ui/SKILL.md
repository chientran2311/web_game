---
name: coding-ui
description: MoniKid coding standard for UI tasks — screen composition, layout, widgets, dialogs, bottom sheets, responsive sizing, theming, localization, and navigation. Use this for anything that lives in a *_screen.dart or widgets/ directory. For logic/state/provider/repository tasks, use coding-standard/SKILL.md instead.
---

# Coding UI — MoniKid Presentation Layer

> **Scope:** Screens, widgets, dialogs, bottom sheets, navigation triggers, theme usage, localization, responsive sizing.
> For provider/repository/state/DI tasks, use `coding-standard/SKILL.md` instead.

---

## 1. Widget Base Class — Two-Tier Rule

### Screens (entry points — `*_screen.dart`)

| Condition | Use |
|-----------|-----|
| Default (needs hooks + provider) | `HookConsumerWidget` |
| No hooks needed | `ConsumerWidget` |
| Needs `TickerProvider` or complex lifecycle | `ConsumerStatefulWidget` + justification comment |

**Never use `ConsumerStatefulWidget` for form screens.** Use `HookConsumerWidget` + `useTextEditingController`.

### Child / extracted widgets (`widgets/` directory)

| Condition | Use |
|-----------|-----|
| All data via constructor | `StatelessWidget` (default) |
| Isolated local animation/gesture state | `StatefulWidget` |
| Must watch a provider directly | `ConsumerWidget` |

> Ask yourself: *Can this widget receive all its data via constructor?*
> Yes → `StatelessWidget`. No rebuild source needed → still `StatelessWidget`.

---

## 2. Screen Template

```dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/core/theme/app_theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/l10n/app_localizations.dart';

class FeatureScreen extends HookConsumerWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;

    // hooks
    final textController = useTextEditingController();

    // provider state
    final state = ref.watch(featureNotifierProvider);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        title: Text(s.featureTitle),
        backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        elevation: 0,
      ),
      body: // ...
    );
  }
}
```

---

## 3. Size Limits — Hard Stops

| File type | Limit | Action when exceeded |
|-----------|-------|---------------------|
| Screen file | 250 lines | Extract widgets to `widgets/` immediately |
| Provider file | 300 lines | Split into sub-providers |
| `build()` method | 100 lines | Extract sub-widget |

When a screen exceeds 250 lines:
1. Create `lib/features/{feature}/widgets/` directory
2. Extract each logical section into its own `StatelessWidget`
3. Name files `{feature}_{section}_section.dart` or `{feature}_{section}_widget.dart`

---

## 4. Responsive Sizing — ScreenUtils Extensions

```dart
// ALWAYS use ScreenUtils extensions (.w/.h/.r/.sp) — never raw pixel values
SizedBox(width: 16.w, height: 16.h)
Text('Hello', style: TextStyle(fontSize: 14.sp))
BorderRadius.circular(12.r)
Icon(Icons.star, size: 24.r)
EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h)

// FORBIDDEN
SizedBox(width: 16)       // ❌ raw pixel
fontSize: 14              // ❌ raw size
BorderRadius.circular(12) // ❌ raw radius
```

**Note:** ScreenUtils is initialized once in `MaterialApp.router` builder (see `lib/app/app.dart`). Do NOT call `ScreenUtils.init(context)` in individual screens.

---

## 5. Colors and Theming — Never Hardcode

```dart
// CORRECT — always use theme tokens
color: AppTheme.primary
color: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight
color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight
color: isDark ? AppTheme.borderDark : AppTheme.borderLight
color: isDark ? Colors.white : AppTheme.textBlack
color: isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey

// FORBIDDEN
color: Color(0xFF1E3A5F)    // ❌ raw hex
color: Colors.blue          // ❌ material color
color: Colors.green         // ❌ material color
```

**Before adding any color:** check `lib/core/theme/theme.dart` and `lib/core/theme/app_theme.dart`.

**Before applying any font:** check `lib/core/font/font.dart`.

---

## 6. Typography — AppTextStyles or textTheme

```dart
// CORRECT
style: AppTextStyles.heading1
style: Theme.of(context).textTheme.titleMedium
style: TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w600,
  color: textColor,
  // fontFamily derived from theme — don't set manually
)

// FORBIDDEN
style: TextStyle(fontFamily: 'Poppins')  // ❌ hardcoded font
```

---

## 7. Localization — Every User-Facing String

```dart
// Setup
final s = context.l10n; // convenience alias

// Usage
Text(s.featureTitle)
Text(s.transactionAddTitle)
hint: s.amountHintText

// FORBIDDEN
Text('Nạp tiền')      // ❌ hardcoded Vietnamese
Text('Top up')        // ❌ hardcoded English
```

**ARB key format:** `featureName_elementDescription`
- Good: `transaction_addTitle`, `aiModel_analyzeTransaction`, `wallet_balanceLabel`
- Bad: `title`, `button1`, `text` ❌

**Always update both files:**
- `lib/l10n/app_vi.arb`
- `lib/l10n/app_en.arb`

**After every ARB change:**
```bash
flutter gen-l10n
```

---

## 8. Navigation — GoRouter Only

```dart
import 'package:go_router/go_router.dart';

// Push a route
context.push(AppRoutes.addTransaction)

// Push with extra data
context.push(AppRoutes.addTransaction, extra: transactionAiResult)

// Replace current route
context.pushReplacement(AppRoutes.home)

// Pop
context.pop()

// Pop with result
context.pop(result)

// FORBIDDEN — never use Navigator directly in this app
Navigator.push(...)          // ❌
Navigator.pushNamed(...)     // ❌
```

**Route paths live in `AppRoutes` constants in `router.dart`.** Never hardcode path strings.

---

## 9. ref.listen — Side Effects and Navigation

Use `ref.listen` for side effects triggered by state changes (navigation, snackbars, dialogs). Never put side effects in `build()` body.

```dart
ref.listen(featureNotifierProvider, (previous, next) {
  final data = next.valueOrNull; // AsyncNotifier
  // or: final data = next;      // sync notifier
  if (data == null) return;

  if (data.status == FeatureStatus.success) {
    context.pop(); // navigate on success
  }
  if (data.status == FeatureStatus.error && data.errorMessage != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data.errorMessage!)),
    );
  }
});
```

---

## 10. useEffect for One-Time Setup

```dart
// Pre-fill form from external data (e.g., AI result)
useEffect(() {
  if (prefillData == null) return null;
  amountController.text = prefillData!.amount.toString();
  noteController.text = prefillData!.note;
  return null; // no cleanup needed
}, []); // empty deps = runs once on mount

// With cleanup
useEffect(() {
  final sub = stream.listen(handler);
  return sub.cancel; // cleanup function
}, [stream]);
```

---

## 11. Loading and Error States

```dart
// AsyncValue pattern (for AsyncNotifier)
final state = ref.watch(featureProvider);

return state.when(
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (error, _) => Center(child: Text(error.toString())),
  data: (data) => _buildContent(data),
);

// Sync notifier pattern
final state = ref.watch(featureProvider);

if (state.isLoading) return const Center(child: CircularProgressIndicator());
if (state.hasError) return Center(child: Text(state.errorMessage ?? ''));
return _buildContent(state);
```

---

## 12. Buttons — Disabled State During Loading

```dart
ElevatedButton(
  onPressed: state.isLoading
      ? null                    // null = disabled
      : () => ref.read(featureProvider.notifier).submit(),
  child: state.isLoading
      ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        )
      : Text(s.submitButton),
)
```

---

## 13. Widget Extraction — When and How

Extract to a new widget when:
- The section has its own logical meaning (header, card, form section)
- The `build()` method would exceed 100 lines without extraction
- The widget is reused in 2+ places

```dart
// Parent screen
body: Column(
  children: [
    FeatureHeaderSection(title: s.title, onBack: context.pop),
    FeatureFormSection(controller: amountController, onSubmit: _submit),
    FeatureActionBar(isLoading: state.isLoading, onTap: _submit),
  ],
)

// Extracted widget — StatelessWidget by default
class FeatureHeaderSection extends StatelessWidget {
  const FeatureHeaderSection({
    super.key,
    required this.title,
    required this.onBack,
  });

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) { ... }
}
```

---

## 14. Common Anti-Patterns — Forbidden

```dart
// ❌ business logic in build()
onPressed: () async {
  final result = await repository.doSomething(); // belongs in notifier
  setState(() { ... });
}

// ❌ ConsumerStatefulWidget for forms
class MyForm extends ConsumerStatefulWidget { ... } // use HookConsumerWidget

// ❌ hardcoded strings
Text('Thêm giao dịch') // use context.l10n.*

// ❌ raw pixel values
SizedBox(width: 16)   // use 16.w

// ❌ material colors
color: Colors.blue    // use AppTheme.primary

// ❌ Navigator instead of GoRouter
Navigator.push(...)   // use context.push(...)

// ❌ side effects in build body
if (state.isSuccess) context.pop(); // use ref.listen
```

---

## 15. Checklist Before Finishing

- [ ] `ScreenUtils.init(context)` is first line in every screen `build()`
- [ ] No hardcoded colors — all from `AppTheme`
- [ ] No hardcoded strings — all from `context.l10n`
- [ ] No raw pixel sizes — all use `.w`, `.h`, `.sp`, `.r`
- [ ] Screen file ≤ 250 lines (extract if needed)
- [ ] `build()` method ≤ 100 lines
- [ ] Side effects via `ref.listen`, not in `build()` body
- [ ] Both `app_vi.arb` and `app_en.arb` updated for new strings
- [ ] `flutter gen-l10n` run after ARB changes
- [ ] `flutter analyze` passes clean
