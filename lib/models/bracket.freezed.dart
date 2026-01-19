// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bracket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Bracket {
  String get id => throw _privateConstructorUsedError;
  List<String> get divisionIds => throw _privateConstructorUsedError;
  List<String> get tableIds => throw _privateConstructorUsedError;
  String? get byeTableId => throw _privateConstructorUsedError;
  int get rounds => throw _privateConstructorUsedError;
  int get currentRound => throw _privateConstructorUsedError;
  bool get finished => throw _privateConstructorUsedError;

  /// Create a copy of Bracket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BracketCopyWith<Bracket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BracketCopyWith<$Res> {
  factory $BracketCopyWith(Bracket value, $Res Function(Bracket) then) =
      _$BracketCopyWithImpl<$Res, Bracket>;
  @useResult
  $Res call(
      {String id,
      List<String> divisionIds,
      List<String> tableIds,
      String? byeTableId,
      int rounds,
      int currentRound,
      bool finished});
}

/// @nodoc
class _$BracketCopyWithImpl<$Res, $Val extends Bracket>
    implements $BracketCopyWith<$Res> {
  _$BracketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bracket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? divisionIds = null,
    Object? tableIds = null,
    Object? byeTableId = freezed,
    Object? rounds = null,
    Object? currentRound = null,
    Object? finished = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      divisionIds: null == divisionIds
          ? _value.divisionIds
          : divisionIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tableIds: null == tableIds
          ? _value.tableIds
          : tableIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      byeTableId: freezed == byeTableId
          ? _value.byeTableId
          : byeTableId // ignore: cast_nullable_to_non_nullable
              as String?,
      rounds: null == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int,
      currentRound: null == currentRound
          ? _value.currentRound
          : currentRound // ignore: cast_nullable_to_non_nullable
              as int,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BracketImplCopyWith<$Res> implements $BracketCopyWith<$Res> {
  factory _$$BracketImplCopyWith(
          _$BracketImpl value, $Res Function(_$BracketImpl) then) =
      __$$BracketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<String> divisionIds,
      List<String> tableIds,
      String? byeTableId,
      int rounds,
      int currentRound,
      bool finished});
}

/// @nodoc
class __$$BracketImplCopyWithImpl<$Res>
    extends _$BracketCopyWithImpl<$Res, _$BracketImpl>
    implements _$$BracketImplCopyWith<$Res> {
  __$$BracketImplCopyWithImpl(
      _$BracketImpl _value, $Res Function(_$BracketImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bracket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? divisionIds = null,
    Object? tableIds = null,
    Object? byeTableId = freezed,
    Object? rounds = null,
    Object? currentRound = null,
    Object? finished = null,
  }) {
    return _then(_$BracketImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      divisionIds: null == divisionIds
          ? _value._divisionIds
          : divisionIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tableIds: null == tableIds
          ? _value._tableIds
          : tableIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      byeTableId: freezed == byeTableId
          ? _value.byeTableId
          : byeTableId // ignore: cast_nullable_to_non_nullable
              as String?,
      rounds: null == rounds
          ? _value.rounds
          : rounds // ignore: cast_nullable_to_non_nullable
              as int,
      currentRound: null == currentRound
          ? _value.currentRound
          : currentRound // ignore: cast_nullable_to_non_nullable
              as int,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BracketImpl extends _Bracket {
  const _$BracketImpl(
      {required this.id,
      final List<String> divisionIds = const [],
      final List<String> tableIds = const [],
      this.byeTableId,
      this.rounds = 3,
      this.currentRound = 0,
      this.finished = false})
      : _divisionIds = divisionIds,
        _tableIds = tableIds,
        super._();

  @override
  final String id;
  final List<String> _divisionIds;
  @override
  @JsonKey()
  List<String> get divisionIds {
    if (_divisionIds is EqualUnmodifiableListView) return _divisionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_divisionIds);
  }

  final List<String> _tableIds;
  @override
  @JsonKey()
  List<String> get tableIds {
    if (_tableIds is EqualUnmodifiableListView) return _tableIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tableIds);
  }

  @override
  final String? byeTableId;
  @override
  @JsonKey()
  final int rounds;
  @override
  @JsonKey()
  final int currentRound;
  @override
  @JsonKey()
  final bool finished;

  @override
  String toString() {
    return 'Bracket(id: $id, divisionIds: $divisionIds, tableIds: $tableIds, byeTableId: $byeTableId, rounds: $rounds, currentRound: $currentRound, finished: $finished)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BracketImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._divisionIds, _divisionIds) &&
            const DeepCollectionEquality().equals(other._tableIds, _tableIds) &&
            (identical(other.byeTableId, byeTableId) ||
                other.byeTableId == byeTableId) &&
            (identical(other.rounds, rounds) || other.rounds == rounds) &&
            (identical(other.currentRound, currentRound) ||
                other.currentRound == currentRound) &&
            (identical(other.finished, finished) ||
                other.finished == finished));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(_divisionIds),
      const DeepCollectionEquality().hash(_tableIds),
      byeTableId,
      rounds,
      currentRound,
      finished);

  /// Create a copy of Bracket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BracketImplCopyWith<_$BracketImpl> get copyWith =>
      __$$BracketImplCopyWithImpl<_$BracketImpl>(this, _$identity);
}

abstract class _Bracket extends Bracket {
  const factory _Bracket(
      {required final String id,
      final List<String> divisionIds,
      final List<String> tableIds,
      final String? byeTableId,
      final int rounds,
      final int currentRound,
      final bool finished}) = _$BracketImpl;
  const _Bracket._() : super._();

  @override
  String get id;
  @override
  List<String> get divisionIds;
  @override
  List<String> get tableIds;
  @override
  String? get byeTableId;
  @override
  int get rounds;
  @override
  int get currentRound;
  @override
  bool get finished;

  /// Create a copy of Bracket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BracketImplCopyWith<_$BracketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
