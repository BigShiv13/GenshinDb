import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_character_file.freezed.dart';
part 'translation_character_file.g.dart';

@freezed
abstract class TranslationCharacterFile implements _$TranslationCharacterFile {
  factory TranslationCharacterFile({
    @required String key,
    @required String name,
    @required String description,
    @required List<TranslationCharacterSkillFile> skills,
    @required List<TranslationCharacterPassiveFile> passives,
    @required List<TranslationCharacterConstellationFile> constellations,
  }) = _TranslationCharacterFile;

  factory TranslationCharacterFile.fromJson(Map<String, dynamic> json) => _$TranslationCharacterFileFromJson(json);
}

@freezed
abstract class TranslationCharacterSkillFile implements _$TranslationCharacterSkillFile {
  factory TranslationCharacterSkillFile({
    @required String key,
    @required String title,
    String description,
    @required List<TranslationCharacterAbilityFile> abilities,
  }) = _TranslationCharacterSkillFile;

  factory TranslationCharacterSkillFile.fromJson(Map<String, dynamic> json) =>
      _$TranslationCharacterSkillFileFromJson(json);
}

@freezed
abstract class TranslationCharacterAbilityFile implements _$TranslationCharacterAbilityFile {
  @late
  bool get hasCommonTranslation => key != null;

  factory TranslationCharacterAbilityFile({
    String key,
    String name,
    String description,
    String secondDescription,
    @required List<String> descriptions,
  }) = _TranslationCharacterAbilityFile;

  factory TranslationCharacterAbilityFile.fromJson(Map<String, dynamic> json) =>
      _$TranslationCharacterAbilityFileFromJson(json);
}

@freezed
abstract class TranslationCharacterPassiveFile implements _$TranslationCharacterPassiveFile {
  factory TranslationCharacterPassiveFile({
    @required String key,
    @required String title,
    @required String description,
    @required List<String> descriptions,
  }) = _TranslationCharacterPassiveFile;

  factory TranslationCharacterPassiveFile.fromJson(Map<String, dynamic> json) =>
      _$TranslationCharacterPassiveFileFromJson(json);
}

@freezed
abstract class TranslationCharacterConstellationFile implements _$TranslationCharacterConstellationFile {
  factory TranslationCharacterConstellationFile({
    @required String key,
    @required String title,
    @required String description,
    String secondDescription,
    @required List<String> descriptions,
  }) = _TranslationCharacterConstellationFile;

  factory TranslationCharacterConstellationFile.fromJson(Map<String, dynamic> json) =>
      _$TranslationCharacterConstellationFileFromJson(json);
}
