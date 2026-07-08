// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'syntax_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyntaxBlock {

 String get id; String get text; BlockType get type; BlockColor get color; bool get isCustom; String? get customValue;
/// Create a copy of SyntaxBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyntaxBlockCopyWith<SyntaxBlock> get copyWith => _$SyntaxBlockCopyWithImpl<SyntaxBlock>(this as SyntaxBlock, _$identity);

  /// Serializes this SyntaxBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyntaxBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.color, color) || other.color == color)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.customValue, customValue) || other.customValue == customValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,type,color,isCustom,customValue);

@override
String toString() {
  return 'SyntaxBlock(id: $id, text: $text, type: $type, color: $color, isCustom: $isCustom, customValue: $customValue)';
}


}

/// @nodoc
abstract mixin class $SyntaxBlockCopyWith<$Res>  {
  factory $SyntaxBlockCopyWith(SyntaxBlock value, $Res Function(SyntaxBlock) _then) = _$SyntaxBlockCopyWithImpl;
@useResult
$Res call({
 String id, String text, BlockType type, BlockColor color, bool isCustom, String? customValue
});




}
/// @nodoc
class _$SyntaxBlockCopyWithImpl<$Res>
    implements $SyntaxBlockCopyWith<$Res> {
  _$SyntaxBlockCopyWithImpl(this._self, this._then);

  final SyntaxBlock _self;
  final $Res Function(SyntaxBlock) _then;

/// Create a copy of SyntaxBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? type = null,Object? color = null,Object? isCustom = null,Object? customValue = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BlockType,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BlockColor,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,customValue: freezed == customValue ? _self.customValue : customValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyntaxBlock].
extension SyntaxBlockPatterns on SyntaxBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyntaxBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyntaxBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyntaxBlock value)  $default,){
final _that = this;
switch (_that) {
case _SyntaxBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyntaxBlock value)?  $default,){
final _that = this;
switch (_that) {
case _SyntaxBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  BlockType type,  BlockColor color,  bool isCustom,  String? customValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyntaxBlock() when $default != null:
return $default(_that.id,_that.text,_that.type,_that.color,_that.isCustom,_that.customValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  BlockType type,  BlockColor color,  bool isCustom,  String? customValue)  $default,) {final _that = this;
switch (_that) {
case _SyntaxBlock():
return $default(_that.id,_that.text,_that.type,_that.color,_that.isCustom,_that.customValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  BlockType type,  BlockColor color,  bool isCustom,  String? customValue)?  $default,) {final _that = this;
switch (_that) {
case _SyntaxBlock() when $default != null:
return $default(_that.id,_that.text,_that.type,_that.color,_that.isCustom,_that.customValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyntaxBlock implements SyntaxBlock {
  const _SyntaxBlock({required this.id, required this.text, required this.type, required this.color, this.isCustom = false, this.customValue});
  factory _SyntaxBlock.fromJson(Map<String, dynamic> json) => _$SyntaxBlockFromJson(json);

@override final  String id;
@override final  String text;
@override final  BlockType type;
@override final  BlockColor color;
@override@JsonKey() final  bool isCustom;
@override final  String? customValue;

/// Create a copy of SyntaxBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyntaxBlockCopyWith<_SyntaxBlock> get copyWith => __$SyntaxBlockCopyWithImpl<_SyntaxBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyntaxBlockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyntaxBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.type, type) || other.type == type)&&(identical(other.color, color) || other.color == color)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.customValue, customValue) || other.customValue == customValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,type,color,isCustom,customValue);

@override
String toString() {
  return 'SyntaxBlock(id: $id, text: $text, type: $type, color: $color, isCustom: $isCustom, customValue: $customValue)';
}


}

/// @nodoc
abstract mixin class _$SyntaxBlockCopyWith<$Res> implements $SyntaxBlockCopyWith<$Res> {
  factory _$SyntaxBlockCopyWith(_SyntaxBlock value, $Res Function(_SyntaxBlock) _then) = __$SyntaxBlockCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, BlockType type, BlockColor color, bool isCustom, String? customValue
});




}
/// @nodoc
class __$SyntaxBlockCopyWithImpl<$Res>
    implements _$SyntaxBlockCopyWith<$Res> {
  __$SyntaxBlockCopyWithImpl(this._self, this._then);

  final _SyntaxBlock _self;
  final $Res Function(_SyntaxBlock) _then;

/// Create a copy of SyntaxBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? type = null,Object? color = null,Object? isCustom = null,Object? customValue = freezed,}) {
  return _then(_SyntaxBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BlockType,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as BlockColor,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,customValue: freezed == customValue ? _self.customValue : customValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
