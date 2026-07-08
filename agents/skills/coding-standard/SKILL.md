---
name: coding-standard
description: MoniKid coding standard for logic, state, provider, repository, model, DI, routing, Firestore, and business logic tasks. Use this for everything that is NOT UI composition. Covers implementation order, naming, Riverpod @riverpod codegen, Freezed models, GetIt registration, error handling, import order, and logging.
---

# Coding Standard — MoniKid Logic Layer

> **Scope:** Provider, Notifier, Repository, Model, DI (GetIt), routing, Firestore, service, state, param, domain logic.
> For UI/screen/widget tasks, use `coding-ui/SKILL.md` instead.

---

## 1. Implementation Order — Never Skip or Reorder

```
plan → schema/Firestore → model (Freezed) → repository interface → repository impl
  → GetIt registration → @riverpod provider/notifier → state (Freezed) → UI hookup
```

Each layer depends on the layer below it. Do not implement a provider before its repository exists and is registered.

---

## 2. Naming — Zero Tolerance

| What | Rule | Anti-pattern |
|------|------|-------------|
| Folders | `snake_case` | `chooseAImodel/` ❌ |
| Files | `snake_case` | `homeStu.dart`, `authProvider.dart` ❌ |
| Screen files | `{feature}_screen.dart` | `home_tab_par.dart` ❌ |
| State files | `{feature}_state.dart` | |
| Provider files | `{feature}_provider.dart` | |
| Repository files | `{feature}_repository.dart` | |
| Model files | `{feature}_model.dart` | |
| Classes | `PascalCase` | `authprovider` ❌ |
| No abbreviations | spell it out | `_stu_`, `_par`, `_repo` ❌ |

---

## 3. State Pattern — Freezed + Status Enum

Every notifier state uses Freezed + a status enum. No exceptions.

```dart
// Status enum — always include these 5 base states, add feature-specific ones after
enum FeatureStatus {
  initial,
  loading,
  success,
  empty,
  error,
  // feature-specific additions below:
  // savingApiKey,
  // apiKeyReady,
}

// State model — always Freezed
@freezed
abstract class FeatureState with _$FeatureState {
  const factory FeatureState({
    @Default(FeatureStatus.initial) FeatureStatus status,
    String? errorMessage,
    // ... feature-specific fields
  }) = _FeatureState;

  const FeatureState._();

  // Computed getters — keep them small and pure
  bool get isLoading => status == FeatureStatus.loading;
  bool get hasError => status == FeatureStatus.error;
}
```

**Rules:**
- Never leave state at `loading` after a failure
- Never use `bool isLoading` as a standalone Freezed field — use the status enum
- Computed getters belong in the `._()` private constructor body

---

## 4. Riverpod Provider Pattern — @riverpod Codegen

Always use `@riverpod` annotation (codegen), never the old `StateNotifierProvider`.

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feature_provider.g.dart';

@riverpod
class FeatureNotifier extends _$FeatureNotifier {
  late Logger _logger;
  late FeatureRepository _repository;

  @override
  FeatureState build() {
    _logger = getIt<Logger>();
    _repository = ref.read(featureRepositoryProvider);
    return const FeatureState();
  }

  Future<void> doSomething() async {
    _logger.d('FeatureNotifier.doSomething: start.');
    state = state.copyWith(status: FeatureStatus.loading, errorMessage: null);

    try {
      final result = await _repository.doSomething();
      _logger.i('FeatureNotifier.doSomething: success. result=$result');
      state = state.copyWith(status: FeatureStatus.success);
    } catch (error, stackTrace) {
      _logger.e('FeatureNotifier.doSomething failed.', error: error, stackTrace: stackTrace);
      state = state.copyWith(
        status: FeatureStatus.error,
        errorMessage: 'Operation failed.',
      );
    }
  }
}
```

**Rules:**
- Fields declared `late` — initialized in `build()`
- `build()` initializes from GetIt and `ref.read()` only — **no direct async calls** in `build()`
- `AsyncNotifier` for async `build()` — use `state.valueOrNull` pattern
- Never use `ref.watch` inside notifier methods — only `ref.read`

### ⚠️ MANDATORY: Future.microtask for async init in build()

If `build()` needs to trigger an async method that writes `state`, it **MUST** use `Future.microtask`. Calling an async method directly causes a synchronous `state =` write before `build()` returns → **"Bad state: uninitialized provider" crash**.

```dart
// ✅ CORRECT — defers until after build() returns
@override
FeatureState build() {
  _logger = getIt<Logger>();
  _repository = ref.read(featureRepositoryProvider);
  Future.microtask(_loadInitialData);   // ← always microtask, never direct call
  return const FeatureState();
}

Future<void> _loadInitialData() async {
  state = state.copyWith(status: FeatureStatus.loading);  // safe: build() already returned
  try {
    final data = await _repository.fetchData();
    _logger.i('_loadInitialData: success. count=${data.length}');
    state = state.copyWith(status: FeatureStatus.success, data: data);
  } catch (error, stackTrace) {
    _logger.e('_loadInitialData failed.', error: error, stackTrace: stackTrace);
    state = state.copyWith(status: FeatureStatus.error, errorMessage: 'Load failed.');
  }
}

// ❌ FORBIDDEN — crashes with "uninitialized provider"
@override
FeatureState build() {
  _loadInitialData();   // ← direct call: state = ... inside runs before build() returns
  return const FeatureState();
}
```

The same rule applies to `useEffect` in screens — always use `Future.microtask` when calling notifier methods:

```dart
// ✅ CORRECT
useEffect(() {
  Future.microtask(() async {
    await ref.read(featureNotifierProvider.notifier).onInit();
  });
  return null;
}, [uid]);

// ❌ FORBIDDEN — calling notifier directly in useEffect callback (not microtask)
useEffect(() {
  ref.read(featureNotifierProvider.notifier).onInit(); // no await, no microtask
  return null;
}, [uid]);
```

### AsyncNotifier Pattern (when build() is async)

```dart
@riverpod
class AsyncFeatureNotifier extends _$AsyncFeatureNotifier {
  @override
  Future<FeatureState> build() async {
    _logger = getIt<Logger>();
    _repository = ref.read(featureRepositoryProvider);
    final data = await _repository.loadInitialData();
    return FeatureState(data: data);
  }

  Future<void> refresh() async {
    final current = state.valueOrNull;
    if (current == null) return;
    // ...
  }
}
```

---

## 5. Repository Pattern

```dart
// Interface
abstract class FeatureRepository {
  Future<void> doSomething(FeatureParam param);
  Stream<List<FeatureModel>> watchAll(String userId);
}

// Implementation
@riverpod
FeatureRepository featureRepository(Ref ref) {
  return FeatureRepositoryImpl(
    logger: getIt<Logger>(),
    firestore: getIt<FirebaseFirestore>(),
  );
}

class FeatureRepositoryImpl implements FeatureRepository {
  FeatureRepositoryImpl({required Logger logger, required FirebaseFirestore firestore})
      : _logger = logger,
        _firestore = firestore;

  final Logger _logger;
  final FirebaseFirestore _firestore;

  @override
  Future<void> doSomething(FeatureParam param) async {
    _logger.d('FeatureRepositoryImpl.doSomething: param=${param.id}');
    try {
      await _firestore.collection('...').doc('...').set(param.toJson());
      _logger.i('FeatureRepositoryImpl.doSomething: success. id=${param.id}');
    } catch (error, stackTrace) {
      _logger.e('FeatureRepositoryImpl.doSomething failed. id=${param.id}',
          error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
```

**Rules:**
- Interface in `lib/repositories/{feature}/{feature}_repository.dart`
- Impl in the same file, class `{Feature}RepositoryImpl`
- Logger injected via constructor — never `getIt<Logger>()` inside a method body
- Log messages in English only
- **Log at entry** (`_logger.d`) with key input values before any async call
- **Log on success** (`_logger.i`) with relevant output after the operation
- **Log on error** (`_logger.e`) with input context, then `rethrow` so the notifier handles it
- Never swallow exceptions in repository — always rethrow after logging

---

## 6. GetIt Registration

New repositories and services MUST be registered in `lib/core/di/di.dart`.

```dart
// Singleton (long-lived service)
getIt.registerLazySingleton<GeminiAiService>(
  () => GeminiAiService(
    logger: getIt<Logger>(),
    secureStorage: getIt<AppSecureStorage>(),
  ),
);

// Factory (new instance per use) — rarely needed in this app
getIt.registerFactory<FeatureRepository>(
  () => FeatureRepositoryImpl(logger: getIt<Logger>(), firestore: getIt<FirebaseFirestore>()),
);
```

**Rules:**
- Read `lib/core/di/di.dart` before registering — check for existing instances
- Prefer `registerLazySingleton` unless there's a strong reason for factory
- Register in the correct section of `di.dart` (services → repositories → ordered)

---

## 7. Freezed Model Pattern

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feature_model.freezed.dart';
part 'feature_model.g.dart'; // only if fromJson/toJson needed

@freezed
abstract class FeatureModel with _$FeatureModel {
  const factory FeatureModel({
    required String id,
    required String label,
    @Default(false) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _FeatureModel;

  factory FeatureModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureModelFromJson(json);
}
```

**Rules:**
- `@freezed abstract class` — not `@Freezed class`
- `part` declarations immediately after imports
- `@JsonKey(name: 'snake_case')` when Firestore/API field differs from Dart field
- Run `dart run build_runner build --delete-conflicting-outputs` after every model change
- Never manually edit `.freezed.dart` or `.g.dart` files

---

## 8. Import Order — Enforced

```dart
import 'dart:async';                              // 1. dart:core
import 'dart:convert';

import 'package:flutter/material.dart';           // 2. flutter:
import 'package:flutter/foundation.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart'; // 3. third-party (pub.dev)
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

import 'package:monikid/core/di/di.dart';         // 4. package:monikid/ (project)
import 'package:monikid/core/storage/app_secure_storage.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
```

**Rules:**
- Alphabetical within each group
- Blank line between groups
- Never put `package:monikid/` before third-party imports

---

## 9. Error Handling — Always Structured

### In providers (notifiers)

Every method that changes state MUST follow this pattern:

```dart
Future<void> doSomething(String id) async {
  // 1. Log entry with key inputs
  _logger.d('FeatureNotifier.doSomething: start. id=$id');

  // 2. Set loading state
  state = state.copyWith(status: FeatureStatus.loading, errorMessage: null);

  try {
    // 3. Perform work
    final result = await _repository.doSomething(id);

    // 4. Log success with key outputs
    _logger.i('FeatureNotifier.doSomething: success. result=${result.id}');

    // 5. Update state to success
    state = state.copyWith(status: FeatureStatus.success, data: result);
  } catch (error, stackTrace) {
    // 6. Log error with full context
    _logger.e('FeatureNotifier.doSomething failed. id=$id',
        error: error, stackTrace: stackTrace);

    // 7. Always update state away from loading
    state = state.copyWith(
      status: FeatureStatus.error,
      errorMessage: 'Operation failed.',
    );
  }
}
```

### In repositories

Every method that reads/writes Firestore MUST follow this pattern:

```dart
Future<FeatureModel> fetchData(String id) async {
  // 1. Log entry
  _logger.d('FeatureRepositoryImpl.fetchData: id=$id');
  try {
    final doc = await _firestore.collection('...').doc(id).get();
    final model = FeatureModel.fromJson(doc.data()!);
    // 2. Log success
    _logger.i('FeatureRepositoryImpl.fetchData: success. id=$id');
    return model;
  } catch (error, stackTrace) {
    // 3. Log error then rethrow — never swallow
    _logger.e('FeatureRepositoryImpl.fetchData failed. id=$id',
        error: error, stackTrace: stackTrace);
    rethrow;
  }
}
```

```dart
// FORBIDDEN patterns
} catch (e) { ... }          // ❌ no stackTrace
} catch (_) { ... }          // ❌ swallowed — hides crash cause
_logger.e('failed');         // ❌ no error/stackTrace params
state = ...;                 // ❌ state write without any try-catch wrapping
```

**Rules:**
- All log messages in English
- User-facing error messages via `context.l10n.*` (never hardcoded Vietnamese in provider)
- Never leave state at `loading` after a catch
- Never write state without a surrounding try-catch (unless it's a simple sync field toggle)
- Repository: always rethrow after logging — let the notifier decide recovery
- Notifier: always handle the rethrown exception and set error state

---

## 10. Logging

```dart
// Injected logger — never print() or debugPrint()
_logger.i('Informational message. key=$value');
_logger.w('Warning: condition occurred.');
_logger.e('Error message.', error: error, stackTrace: stackTrace);
_logger.d('Debug detail. payload=$payload'); // dev-only detail

// FORBIDDEN
print('something');           // ❌
debugPrint('something');      // ❌
developer.log('something');   // ❌
```

---

## 11. Source of Truth Map

| What | Where — read this before touching |
|------|----------------------------------|
| Auth/session/routing | `authSessionProvider` + `router.dart` |
| Transaction shared state | `transactionHistoryProvider` |
| Statistic analytics | `StatisticProvider` + `StatisticRepository` |
| Firestore schema | `docs/firebase_document_design.md` |
| DI bootstrap | `lib/core/di/di.dart` + `lib/main.dart` |
| Feature requirements | Speckit `spec.md` |
| Execution plan | GSD `CONTEXT.md` + `*-PLAN.md` |

---

## 12. Things That Will Break the App

- Adding a repository without registering it in GetIt
- Changing Firestore paths without reading `docs/firebase_document_design.md`
- Changing auth routing without reading `docs/auth_refactor_summary.md`
- Editing `.g.dart` or `.freezed.dart` files manually
- Using `ref.watch` inside a notifier method body
- Leaving a `catch` block without updating state away from `loading`
- Calling an async init method **directly** from `build()` without `Future.microtask` → "Bad state: uninitialized provider" crash
- Writing `state =` inside an async method called from `build()` before the first `await` — the provider hasn't initialized yet
- Omitting try-catch around any async state write in a notifier — unhandled exceptions crash the app silently

---

## 13. Checklist Before Finishing

```bash
flutter analyze                                              # must pass clean
dart run build_runner build --delete-conflicting-outputs    # after model/provider/repo changes
flutter gen-l10n                                            # after ARB changes
flutter test                                                # targeted or full suite
```

Then create or update `docs/{feature}_summary.md` documenting what changed and why.
