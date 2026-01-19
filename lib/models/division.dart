import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'division.freezed.dart';

@freezed
class Division with _$Division {
  const Division._();

  const factory Division({
    required String id,
    @Default("") String name,
    @Default(-1) int number,
    String? parentId, // Tournament ID
    @Default([]) List<String> playerIds,
  }) = _Division;

  factory Division.create(String name, int number) => Division(
        id: const Uuid().v4(),
        name: name,
        number: number,
      );
}
