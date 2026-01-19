import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'pairing.freezed.dart';

@freezed
class Pairing with _$Pairing {
  const Pairing._();

  const factory Pairing({
    required String id,
    required String name,
    required int number,
    String? playerOneId,
    String? playerTwoId,
    @Default(false) bool finished,
    @Default(0) int winner, // 0=none, 1=playerOne, 2=playerTwo, 3=tie
  }) = _Pairing;

  factory Pairing.create({required int number, required String name}) =>
      Pairing(
        id: const Uuid().v4(),
        name: name,
        number: number,
      );

  /// Create a bye pairing (singleton-style ID)
  factory Pairing.bye() => const Pairing(
        id: 'bye',
        name: 'Bye',
        number: -1,
        finished: true,
      );

  /// Create a dropped status placeholder
  factory Pairing.dropped() => const Pairing(
        id: 'dropped',
        name: 'Dropped',
        number: -2,
        finished: true,
      );
}
