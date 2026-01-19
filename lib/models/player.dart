import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'player.freezed.dart';

@freezed
class Player with _$Player {
  const Player._();

  const factory Player({
    required String id,
    @Default("") String name,
    String? divisionId,
    @Default("bye") String tableStatus, // "bye", "dropped", or pairing ID
    @Default([]) List<String> winIds,
    @Default([]) List<String> lossIds,
    @Default([]) List<String> tieIds,
    @Default(false) bool bye,
    @Default(false) bool dropped,
  }) = _Player;

  factory Player.create({String name = ""}) => Player(
        id: const Uuid().v4(),
        name: name,
      );

  /// Score: 3 points per win, 1 per tie, 3 for bye
  int get score => 3 * winIds.length + 1 * tieIds.length + (bye ? 3 : 0);

  /// All opponent IDs from wins, losses, and ties
  List<String> get opponentIds => [...winIds, ...lossIds, ...tieIds];

  /// Win percentage (wins / total opponents)
  double get winPercent =>
      opponentIds.isEmpty ? 0 : winIds.length / opponentIds.length;
}
