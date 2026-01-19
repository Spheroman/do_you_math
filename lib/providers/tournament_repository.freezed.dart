// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournament_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TournamentRepository {
  List<Tournament> get tournaments => throw _privateConstructorUsedError;
  List<Division> get divisions => throw _privateConstructorUsedError;
  List<Player> get players => throw _privateConstructorUsedError;
  List<Pairing> get pairings => throw _privateConstructorUsedError;
  List<Bracket> get brackets => throw _privateConstructorUsedError;
  int get currentTournamentIndex => throw _privateConstructorUsedError;

  /// Create a copy of TournamentRepository
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TournamentRepositoryCopyWith<TournamentRepository> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentRepositoryCopyWith<$Res> {
  factory $TournamentRepositoryCopyWith(TournamentRepository value,
          $Res Function(TournamentRepository) then) =
      _$TournamentRepositoryCopyWithImpl<$Res, TournamentRepository>;
  @useResult
  $Res call(
      {List<Tournament> tournaments,
      List<Division> divisions,
      List<Player> players,
      List<Pairing> pairings,
      List<Bracket> brackets,
      int currentTournamentIndex});
}

/// @nodoc
class _$TournamentRepositoryCopyWithImpl<$Res,
        $Val extends TournamentRepository>
    implements $TournamentRepositoryCopyWith<$Res> {
  _$TournamentRepositoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TournamentRepository
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournaments = null,
    Object? divisions = null,
    Object? players = null,
    Object? pairings = null,
    Object? brackets = null,
    Object? currentTournamentIndex = null,
  }) {
    return _then(_value.copyWith(
      tournaments: null == tournaments
          ? _value.tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<Tournament>,
      divisions: null == divisions
          ? _value.divisions
          : divisions // ignore: cast_nullable_to_non_nullable
              as List<Division>,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<Player>,
      pairings: null == pairings
          ? _value.pairings
          : pairings // ignore: cast_nullable_to_non_nullable
              as List<Pairing>,
      brackets: null == brackets
          ? _value.brackets
          : brackets // ignore: cast_nullable_to_non_nullable
              as List<Bracket>,
      currentTournamentIndex: null == currentTournamentIndex
          ? _value.currentTournamentIndex
          : currentTournamentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TournamentRepositoryImplCopyWith<$Res>
    implements $TournamentRepositoryCopyWith<$Res> {
  factory _$$TournamentRepositoryImplCopyWith(_$TournamentRepositoryImpl value,
          $Res Function(_$TournamentRepositoryImpl) then) =
      __$$TournamentRepositoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Tournament> tournaments,
      List<Division> divisions,
      List<Player> players,
      List<Pairing> pairings,
      List<Bracket> brackets,
      int currentTournamentIndex});
}

/// @nodoc
class __$$TournamentRepositoryImplCopyWithImpl<$Res>
    extends _$TournamentRepositoryCopyWithImpl<$Res, _$TournamentRepositoryImpl>
    implements _$$TournamentRepositoryImplCopyWith<$Res> {
  __$$TournamentRepositoryImplCopyWithImpl(_$TournamentRepositoryImpl _value,
      $Res Function(_$TournamentRepositoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TournamentRepository
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tournaments = null,
    Object? divisions = null,
    Object? players = null,
    Object? pairings = null,
    Object? brackets = null,
    Object? currentTournamentIndex = null,
  }) {
    return _then(_$TournamentRepositoryImpl(
      tournaments: null == tournaments
          ? _value._tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as List<Tournament>,
      divisions: null == divisions
          ? _value._divisions
          : divisions // ignore: cast_nullable_to_non_nullable
              as List<Division>,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<Player>,
      pairings: null == pairings
          ? _value._pairings
          : pairings // ignore: cast_nullable_to_non_nullable
              as List<Pairing>,
      brackets: null == brackets
          ? _value._brackets
          : brackets // ignore: cast_nullable_to_non_nullable
              as List<Bracket>,
      currentTournamentIndex: null == currentTournamentIndex
          ? _value.currentTournamentIndex
          : currentTournamentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TournamentRepositoryImpl extends _TournamentRepository {
  const _$TournamentRepositoryImpl(
      {final List<Tournament> tournaments = const [],
      final List<Division> divisions = const [],
      final List<Player> players = const [],
      final List<Pairing> pairings = const [],
      final List<Bracket> brackets = const [],
      this.currentTournamentIndex = -1})
      : _tournaments = tournaments,
        _divisions = divisions,
        _players = players,
        _pairings = pairings,
        _brackets = brackets,
        super._();

  final List<Tournament> _tournaments;
  @override
  @JsonKey()
  List<Tournament> get tournaments {
    if (_tournaments is EqualUnmodifiableListView) return _tournaments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tournaments);
  }

  final List<Division> _divisions;
  @override
  @JsonKey()
  List<Division> get divisions {
    if (_divisions is EqualUnmodifiableListView) return _divisions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_divisions);
  }

  final List<Player> _players;
  @override
  @JsonKey()
  List<Player> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<Pairing> _pairings;
  @override
  @JsonKey()
  List<Pairing> get pairings {
    if (_pairings is EqualUnmodifiableListView) return _pairings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pairings);
  }

  final List<Bracket> _brackets;
  @override
  @JsonKey()
  List<Bracket> get brackets {
    if (_brackets is EqualUnmodifiableListView) return _brackets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_brackets);
  }

  @override
  @JsonKey()
  final int currentTournamentIndex;

  @override
  String toString() {
    return 'TournamentRepository(tournaments: $tournaments, divisions: $divisions, players: $players, pairings: $pairings, brackets: $brackets, currentTournamentIndex: $currentTournamentIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TournamentRepositoryImpl &&
            const DeepCollectionEquality()
                .equals(other._tournaments, _tournaments) &&
            const DeepCollectionEquality()
                .equals(other._divisions, _divisions) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality().equals(other._pairings, _pairings) &&
            const DeepCollectionEquality().equals(other._brackets, _brackets) &&
            (identical(other.currentTournamentIndex, currentTournamentIndex) ||
                other.currentTournamentIndex == currentTournamentIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tournaments),
      const DeepCollectionEquality().hash(_divisions),
      const DeepCollectionEquality().hash(_players),
      const DeepCollectionEquality().hash(_pairings),
      const DeepCollectionEquality().hash(_brackets),
      currentTournamentIndex);

  /// Create a copy of TournamentRepository
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TournamentRepositoryImplCopyWith<_$TournamentRepositoryImpl>
      get copyWith =>
          __$$TournamentRepositoryImplCopyWithImpl<_$TournamentRepositoryImpl>(
              this, _$identity);
}

abstract class _TournamentRepository extends TournamentRepository {
  const factory _TournamentRepository(
      {final List<Tournament> tournaments,
      final List<Division> divisions,
      final List<Player> players,
      final List<Pairing> pairings,
      final List<Bracket> brackets,
      final int currentTournamentIndex}) = _$TournamentRepositoryImpl;
  const _TournamentRepository._() : super._();

  @override
  List<Tournament> get tournaments;
  @override
  List<Division> get divisions;
  @override
  List<Player> get players;
  @override
  List<Pairing> get pairings;
  @override
  List<Bracket> get brackets;
  @override
  int get currentTournamentIndex;

  /// Create a copy of TournamentRepository
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TournamentRepositoryImplCopyWith<_$TournamentRepositoryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
