import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'bracket.freezed.dart';

@freezed
class Bracket with _$Bracket {
  const Bracket._();

  const factory Bracket({
    required String id,
    @Default([]) List<String> divisionIds,
    @Default([]) List<String> tableIds,
    String? byeTableId,
    @Default(3) int rounds,
    @Default(0) int currentRound,
    @Default(false) bool finished,
  }) = _Bracket;

  factory Bracket.create() => Bracket(id: const Uuid().v4());

  /// Calculate number of rounds based on player count
  static int calculateRounds(int numPlayers) {
    int i = (numPlayers - 1) >> 3;
    int rounds = 3;
    while (i > 0) {
      rounds++;
      i >>= 1;
    }
    return rounds;
  }
}
