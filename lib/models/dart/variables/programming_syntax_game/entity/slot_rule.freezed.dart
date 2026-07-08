// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slot_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SlotRule {

 BlockType get type; String get val; String get errMsg;
/// Create a copy of SlotRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotRuleCopyWith<SlotRule> get copyWith => _$SlotRuleCopyWithImpl<SlotRule>(this as SlotRule, _$identity);

  /// Serializes this SlotRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotRule&&(identical(other.type, type) || other.type == type)&&(identical(other.val, val) || other.val == val)&&(identical(other.errMsg, errMsg) || other.errMsg == errMsg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,val,errMsg);

@override
String toString() {
  return 'SlotRule(type: $type, val: $val, errMsg: $errMsg)';
}


}

/// @nodoc
abstract mixin class $SlotRuleCopyWith<$Res>  {
  factory $SlotRuleCopyWith(SlotRule value, $Res Function(SlotRule) _then) = _$SlotRuleCopyWithImpl;
@useResult
$Res call({
 BlockType type, String val, String errMsg
});




}
/// @nodoc
class _$SlotRuleCopyWithImpl<$Res>
    implements $SlotRuleCopyWith<$Res> {
  _$SlotRuleCopyWithImpl(this._self, this._then);

  final SlotRule _self;
  final $Res Function(SlotRule) _then;

/// Create a copy of SlotRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? val = null,Object? errMsg = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BlockType,val: null == val ? _self.val : val // ignore: cast_nullable_to_non_nullable
as String,errMsg: null == errMsg ? _self.errMsg : errMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SlotRule].
extension SlotRulePatterns on SlotRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlotRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlotRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlotRule value)  $default,){
final _that = this;
switch (_that) {
case _SlotRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlotRule value)?  $default,){
final _that = this;
switch (_that) {
case _SlotRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlockType type,  String val,  String errMsg)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlotRule() when $default != null:
return $default(_that.type,_that.val,_that.errMsg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlockType type,  String val,  String errMsg)  $default,) {final _that = this;
switch (_that) {
case _SlotRule():
return $default(_that.type,_that.val,_that.errMsg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlockType type,  String val,  String errMsg)?  $default,) {final _that = this;
switch (_that) {
case _SlotRule() when $default != null:
return $default(_that.type,_that.val,_that.errMsg);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SlotRule implements SlotRule {
  const _SlotRule({required this.type, required this.val, required this.errMsg});
  factory _SlotRule.fromJson(Map<String, dynamic> json) => _$SlotRuleFromJson(json);

@override final  BlockType type;
@override final  String val;
@override final  String errMsg;

/// Create a copy of SlotRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotRuleCopyWith<_SlotRule> get copyWith => __$SlotRuleCopyWithImpl<_SlotRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlotRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotRule&&(identical(other.type, type) || other.type == type)&&(identical(other.val, val) || other.val == val)&&(identical(other.errMsg, errMsg) || other.errMsg == errMsg));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,val,errMsg);

@override
String toString() {
  return 'SlotRule(type: $type, val: $val, errMsg: $errMsg)';
}


}

/// @nodoc
abstract mixin class _$SlotRuleCopyWith<$Res> implements $SlotRuleCopyWith<$Res> {
  factory _$SlotRuleCopyWith(_SlotRule value, $Res Function(_SlotRule) _then) = __$SlotRuleCopyWithImpl;
@override @useResult
$Res call({
 BlockType type, String val, String errMsg
});




}
/// @nodoc
class __$SlotRuleCopyWithImpl<$Res>
    implements _$SlotRuleCopyWith<$Res> {
  __$SlotRuleCopyWithImpl(this._self, this._then);

  final _SlotRule _self;
  final $Res Function(_SlotRule) _then;

/// Create a copy of SlotRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? val = null,Object? errMsg = null,}) {
  return _then(_SlotRule(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BlockType,val: null == val ? _self.val : val // ignore: cast_nullable_to_non_nullable
as String,errMsg: null == errMsg ? _self.errMsg : errMsg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
