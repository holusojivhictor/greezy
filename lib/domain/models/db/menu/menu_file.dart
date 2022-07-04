import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/domain/models/models.dart';

part 'menu_file.freezed.dart';
part 'menu_file.g.dart';

@freezed
class MenuFile with _$MenuFile {
  factory MenuFile({
    required List<MenuFileModel> menu,
  }) = _MenuFile;

  MenuFile._();

  factory MenuFile.fromJson(Map<String, dynamic> json) => _$MenuFileFromJson(json);
}