import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

/// Experience entry synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    this.id,
    required this.title,
    required this.description,
    this.organization = '',
    this.period = '',
    this.logo = '',
    this.location = '',
    this.highlights = const [],
    this.tags = const [],
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String description;
  @JsonKey(defaultValue: '')
  final String organization;
  @JsonKey(defaultValue: '')
  final String period;
  @JsonKey(defaultValue: '')
  final String logo;
  @JsonKey(defaultValue: '')
  final String location;
  @JsonKey(defaultValue: <String>[])
  final List<String> highlights;
  @JsonKey(defaultValue: <String>[])
  final List<String> tags;
  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;
  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;
  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
