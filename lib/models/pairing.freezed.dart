// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pairing.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Pairing {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String? get playerOneId => throw _privateConstructorUsedError;
  String? get playerTwoId => throw _privateConstructorUsedError;
  bool get finished => throw _privateConstructorUsedError;
  int get winner => throw _privateConstructorUsedError;

  /// Create a copy of Pairing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PairingCopyWith<Pairing> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairingCopyWith<$Res> {
  factory $PairingCopyWith(Pairing value, $Res Function(Pairing) then) =
      _$PairingCopyWithImpl<$Res, Pairing>;
  @useResult
  $Res call(
      {String id,
      String name,
      int number,
      String? playerOneId,
      String? playerTwoId,
      bool finished,
      int winner});
}

/// @nodoc
class _$PairingCopyWithImpl<$Res, $Val extends Pairing>
    implements $PairingCopyWith<$Res> {
  _$PairingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pairing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? number = null,
    Object? playerOneId = freezed,
    Object? playerTwoId = freezed,
    Object? finished = null,
    Object? winner = null,
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
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      playerOneId: freezed == playerOneId
          ? _value.playerOneId
          : playerOneId // ignore: cast_nullable_to_non_nullable
              as String?,
      playerTwoId: freezed == playerTwoId
          ? _value.playerTwoId
          : playerTwoId // ignore: cast_nullable_to_non_nullable
              as String?,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      winner: null == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PairingImplCopyWith<$Res> implements $PairingCopyWith<$Res> {
  factory _$$PairingImplCopyWith(
          _$PairingImpl value, $Res Function(_$PairingImpl) then) =
      __$$PairingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int number,
      String? playerOneId,
      String? playerTwoId,
      bool finished,
      int winner});
}

/// @nodoc
class __$$PairingImplCopyWithImpl<$Res>
    extends _$PairingCopyWithImpl<$Res, _$PairingImpl>
    implements _$$PairingImplCopyWith<$Res> {
  __$$PairingImplCopyWithImpl(
      _$PairingImpl _value, $Res Function(_$PairingImpl) _then)
      : super(_value, _then);

  /// Create a copy of Pairing
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? number = null,
    Object? playerOneId = freezed,
    Object? playerTwoId = freezed,
    Object? finished = null,
    Object? winner = null,
  }) {
    return _then(_$PairingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      playerOneId: freezed == playerOneId
          ? _value.playerOneId
          : playerOneId // ignore: cast_nullable_to_non_nullable
              as String?,
      playerTwoId: freezed == playerTwoId
          ? _value.playerTwoId
          : playerTwoId // ignore: cast_nullable_to_non_nullable
              as String?,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      winner: null == winner
          ? _value.winner
          : winner // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PairingImpl extends _Pairing {
  const _$PairingImpl(
      {required this.id,
      required this.name,
      required this.number,
      this.playerOneId,
      this.playerTwoId,
      this.finished = false,
      this.winner = 0})
      : super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final int number;
  @override
  final String? playerOneId;
  @override
  final String? playerTwoId;
  @override
  @JsonKey()
  final bool finished;
  @override
  @JsonKey()
  final int winner;

  @override
  String toString() {
    return 'Pairing(id: $id, name: $name, number: $number, playerOneId: $playerOneId, playerTwoId: $playerTwoId, finished: $finished, winner: $winner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PairingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.playerOneId, playerOneId) ||
                other.playerOneId == playerOneId) &&
            (identical(other.playerTwoId, playerTwoId) ||
                other.playerTwoId == playerTwoId) &&
            (identical(other.finished, finished) ||
                other.finished == finished) &&
            (identical(other.winner, winner) || other.winner == winner));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, number, playerOneId,
      playerTwoId, finished, winner);

  /// Create a copy of Pairing
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PairingImplCopyWith<_$PairingImpl> get copyWith =>
      __$$PairingImplCopyWithImpl<_$PairingImpl>(this, _$identity);
}

abstract class _Pairing extends Pairing {
  const factory _Pairing(
      {required final String id,
      required final String name,
      required final int number,
      final String? playerOneId,
      final String? playerTwoId,
      final bool finished,
      final int winner}) = _$PairingImpl;
  const _Pairing._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  int get number;
  @override
  String? get playerOneId;
  @override
  String? get playerTwoId;
  @override
  bool get finished;
  @override
  int get winner;

  /// Create a copy of Pairing
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PairingImplCopyWith<_$PairingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
