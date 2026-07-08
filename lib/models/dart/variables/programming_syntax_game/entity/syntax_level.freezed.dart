// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'syntax_level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyntaxLevel {

 int get level; String get quest; List<String> get expected; Map<String, SlotRule> get rules;
/// Create a copy of SyntaxLevel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyntaxLevelCopyWith<SyntaxLevel> get copyWith => _$SyntaxLevelCopyWithImpl<SyntaxLevel>(this as SyntaxLevel, _$identity);

  /// Serializes this SyntaxLevel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyntaxLevel&&(identical(other.level, level) || other.level == level)&&(identical(other.quest, quest) || other.quest == quest)&&const DeepCollectionEquality().equals(other.expected, expected)&&const DeepCollectionEquality().equals(other.rules, rules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,quest,const DeepCollectionEquality().hash(expected),const DeepCollectionEquality().hash(rules));

@override
String toString() {
  return 'SyntaxLevel(level: $level, quest: $quest, expected: $expected, rules: $rules)';
}


}

/// @nodoc
abstract mixin class $SyntaxLevelCopyWith<$Res>  {
  factory $SyntaxLevelCopyWith(SyntaxLevel value, $Res Function(SyntaxLevel) _then) = _$SyntaxLevelCopyWithImpl;
@useResult
$Res call({
 int level, String quest, List<String> expected, Map<String, SlotRule> rules
});




}
/// @nodoc
class _$SyntaxLevelCopyWithImpl<$Res>
    implements $SyntaxLevelCopyWith<$Res> {
  _$SyntaxLevelCopyWithImpl(this._self, this._then);

  final SyntaxLevel _self;
  final $Res Function(SyntaxLevel) _then;

/// Create a copy of SyntaxLevel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? level = null,Object? quest = null,Object? expected = null,Object? rules = null,}) {
  return _then(_self.copyWith(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,quest: null == quest ? _self.quest : quest // ignore: cast_nullable_to_non_nullable
as String,expected: null == expected ? _self.expected : expected // ignore: cast_nullable_to_non_nullable
as List<String>,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as Map<String, SlotRule>,
  ));
}

}


/// Adds pattern-matching-related methods to [SyntaxLevel].
extension SyntaxLevelPatterns on SyntaxLevel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyntaxLevel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyntaxLevel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyntaxLevel value)  $default,){
final _that = this;
switch (_that) {
case _SyntaxLevel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyntaxLevel value)?  $default,){
final _that = this;
switch (_that) {
case _SyntaxLevel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int level,  String quest,  List<String> expected,  Map<String, SlotRule> rules)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyntaxLevel() when $default != null:
return $default(_that.level,_that.quest,_that.expected,_that.rules);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int level,  String quest,  List<String> expected,  Map<String, SlotRule> rules)  $default,) {final _that = this;
switch (_that) {
case _SyntaxLevel():
return $default(_that.level,_that.quest,_that.expected,_that.rules);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int level,  String quest,  List<String> expected,  Map<String, SlotRule> rules)?  $default,) {final _that = this;
switch (_that) {
case _SyntaxLevel() when $default != null:
return $default(_that.level,_that.quest,_that.expected,_that.rules);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyntaxLevel implements SyntaxLevel {
  const _SyntaxLevel({required this.level, required this.quest, required final  List<String> expected, required final  Map<String, SlotRule> rules}): _expected = expected,_rules = rules;
  factory _SyntaxLevel.fromJson(Map<String, dynamic> json) => _$SyntaxLevelFromJson(json);

@override final  int level;
@override final  String quest;
 final  List<String> _expected;
@override List<String> get expected {
  if (_expected is EqualUnmodifiableListView) return _expected;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expected);
}

 final  Map<String, SlotRule> _rules;
@override Map<String, SlotRule> get rules {
  if (_rules is EqualUnmodifiableMapView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rules);
}


/// Create a copy of SyntaxLevel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyntaxLevelCopyWith<_SyntaxLevel> get copyWith => __$SyntaxLevelCopyWithImpl<_SyntaxLevel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyntaxLevelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyntaxLevel&&(identical(other.level, level) || other.level == level)&&(identical(other.quest, quest) || other.quest == quest)&&const DeepCollectionEquality().equals(other._expected, _expected)&&const DeepCollectionEquality().equals(other._rules, _rules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,level,quest,const DeepCollectionEquality().hash(_expected),const DeepCollectionEquality().hash(_rules));

@override
String toString() {
  return 'SyntaxLevel(level: $level, quest: $quest, expected: $expected, rules: $rules)';
}


}

/// @nodoc
abstract mixin class _$SyntaxLevelCopyWith<$Res> implements $SyntaxLevelCopyWith<$Res> {
  factory _$SyntaxLevelCopyWith(_SyntaxLevel value, $Res Function(_SyntaxLevel) _then) = __$SyntaxLevelCopyWithImpl;
@override @useResult
$Res call({
 int level, String quest, List<String> expected, Map<String, SlotRule> rules
});




}
/// @nodoc
class __$SyntaxLevelCopyWithImpl<$Res>
    implements _$SyntaxLevelCopyWith<$Res> {
  __$SyntaxLevelCopyWithImpl(this._self, this._then);

  final _SyntaxLevel _self;
  final $Res Function(_SyntaxLevel) _then;

/// Create a copy of SyntaxLevel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? level = null,Object? quest = null,Object? expected = null,Object? rules = null,}) {
  return _then(_SyntaxLevel(
level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,quest: null == quest ? _self.quest : quest // ignore: cast_nullable_to_non_nullable
as String,expected: null == expected ? _self._expected : expected // ignore: cast_nullable_to_non_nullable
as List<String>,rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as Map<String, SlotRule>,
  ));
}


}

// dart format on
