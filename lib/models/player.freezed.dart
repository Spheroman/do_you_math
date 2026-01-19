// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Player {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get divisionId => throw _privateConstructorUsedError;
  String get tableStatus =>
      throw _privateConstructorUsedError; // "bye", "dropped", or pairing ID
  List<String> get winIds => throw _privateConstructorUsedError;
  List<String> get lossIds => throw _privateConstructorUsedError;
  List<String> get tieIds => throw _privateConstructorUsedError;
  bool get bye => throw _privateConstructorUsedError;
  bool get dropped => throw _privateConstructorUsedError;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? divisionId,
      String tableStatus,
      List<String> winIds,
      List<String> lossIds,
      List<String> tieIds,
      bool bye,
      bool dropped});
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? divisionId = freezed,
    Object? tableStatus = null,
    Object? winIds = null,
    Object? lossIds = null,
    Object? tieIds = null,
    Object? bye = null,
    Object? dropped = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      divisionId: freezed == divisionId
          ? _value.divisionId
          : divisionId // ignore: cast_nullable_to_non_nullable
              as String?,
      tableStatus: null == tableStatus
          ? _value.tableStatus
          : tableStatus // ignore: cast_nullable_to_non_nullable
              as String,
      winIds: null == winIds
          ? _value.winIds
          : winIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lossIds: null == lossIds
          ? _value.lossIds
          : lossIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tieIds: null == tieIds
          ? _value.tieIds
          : tieIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bye: null == bye
          ? _value.bye
          : bye // ignore: cast_nullable_to_non_nullable
              as bool,
      dropped: null == dropped
          ? _value.dropped
          : dropped // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerImplCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$PlayerImplCopyWith(
          _$PlayerImpl value, $Res Function(_$PlayerImpl) then) =
      __$$PlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? divisionId,
      String tableStatus,
      List<String> winIds,
      List<String> lossIds,
      List<String> tieIds,
      bool bye,
      bool dropped});
}

/// @nodoc
class __$$PlayerImplCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$PlayerImpl>
    implements _$$PlayerImplCopyWith<$Res> {
  __$$PlayerImplCopyWithImpl(
      _$PlayerImpl _value, $Res Function(_$PlayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? divisionId = freezed,
    Object? tableStatus = null,
    Object? winIds = null,
    Object? lossIds = null,
    Object? tieIds = null,
    Object? bye = null,
    Object? dropped = null,
  }) {
    return _then(_$PlayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      divisionId: freezed == divisionId
          ? _value.divisionId
          : divisionId // ignore: cast_nullable_to_non_nullable
              as String?,
      tableStatus: null == tableStatus
          ? _value.tableStatus
          : tableStatus // ignore: cast_nullable_to_non_nullable
              as String,
      winIds: null == winIds
          ? _value._winIds
          : winIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lossIds: null == lossIds
          ? _value._lossIds
          : lossIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tieIds: null == tieIds
          ? _value._tieIds
          : tieIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bye: null == bye
          ? _value.bye
          : bye // ignore: cast_nullable_to_non_nullable
              as bool,
      dropped: null == dropped
          ? _value.dropped
          : dropped // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$PlayerImpl extends _Player {
  const _$PlayerImpl(
      {required this.id,
      this.name = "",
      this.divisionId,
      this.tableStatus = "bye",
      final List<String> winIds = const [],
      final List<String> lossIds = const [],
      final List<String> tieIds = const [],
      this.bye = false,
      this.dropped = false})
      : _winIds = winIds,
        _lossIds = lossIds,
        _tieIds = tieIds,
        super._();

  @override
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  final String? divisionId;
  @override
  @JsonKey()
  final String tableStatus;
// "bye", "dropped", or pairing ID
  final List<String> _winIds;
// "bye", "dropped", or pairing ID
  @override
  @JsonKey()
  List<String> get winIds {
    if (_winIds is EqualUnmodifiableListView) return _winIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_winIds);
  }

  final List<String> _lossIds;
  @override
  @JsonKey()
  List<String> get lossIds {
    if (_lossIds is EqualUnmodifiableListView) return _lossIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lossIds);
  }

  final List<String> _tieIds;
  @override
  @JsonKey()
  List<String> get tieIds {
    if (_tieIds is EqualUnmodifiableListView) return _tieIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tieIds);
  }

  @override
  @JsonKey()
  final bool bye;
  @override
  @JsonKey()
  final bool dropped;

  @override
  String toString() {
    return 'Player(id: $id, name: $name, divisionId: $divisionId, tableStatus: $tableStatus, winIds: $winIds, lossIds: $lossIds, tieIds: $tieIds, bye: $bye, dropped: $dropped)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.divisionId, divisionId) ||
                other.divisionId == divisionId) &&
            (identical(other.tableStatus, tableStatus) ||
                other.tableStatus == tableStatus) &&
            const DeepCollectionEquality().equals(other._winIds, _winIds) &&
            const DeepCollectionEquality().equals(other._lossIds, _lossIds) &&
            const DeepCollectionEquality().equals(other._tieIds, _tieIds) &&
            (identical(other.bye, bye) || other.bye == bye) &&
            (identical(other.dropped, dropped) || other.dropped == dropped));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      divisionId,
      tableStatus,
      const DeepCollectionEquality().hash(_winIds),
      const DeepCollectionEquality().hash(_lossIds),
      const DeepCollectionEquality().hash(_tieIds),
      bye,
      dropped);

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      __$$PlayerImplCopyWithImpl<_$PlayerImpl>(this, _$identity);
}

abstract class _Player extends Player {
  const factory _Player(
      {required final String id,
      final String name,
      final String? divisionId,
      final String tableStatus,
      final List<String> winIds,
      final List<String> lossIds,
      final List<String> tieIds,
      final bool bye,
      final bool dropped}) = _$PlayerImpl;
  const _Player._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  String? get divisionId;
  @override
  String get tableStatus; // "bye", "dropped", or pairing ID
  @override
  List<String> get winIds;
  @override
  List<String> get lossIds;
  @override
  List<String> get tieIds;
  @override
  bool get bye;
  @override
  bool get dropped;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
