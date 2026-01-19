import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'tournament.freezed.dart';

@freezed
class Tournament with _$Tournament {
  const Tournament._();

  const factory Tournament({
    required String id,
    @Default("") String name,
    @Default([]) List<String> bracketIds,
    @Default([]) List<String> divisionIds,
    @Default([]) List<String> tableIds,
    @Default([]) List<String> playerIds,
    @Default(0) int lastDivisionAddedTo,
    @Default(false) bool started,
    @Default(0) int round,
  }) = _Tournament;

  factory Tournament.create(String name) => Tournament(
        id: const Uuid().v4(),
        name: name,
      );
}
