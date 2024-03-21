import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

typedef JsonMap = Map<String, dynamic>;

class Todo extends Equatable {
  Todo({
    required this.title,
    String? id,
    this.description = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or bot emply',
        ),
        id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static Todo fromJson(JsonMap json) => Todo(
        title: json['title'] as String,
        id: json['id'] as String?,
        description: json['description'] as String? ?? '',
        isCompleted: json['isCompleted'] as bool? ?? false,
      );

  Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
        'id': instance.id,
        'title': instance.title,
        'description': instance.description,
        'isCompleted': instance.isCompleted,
      };

  /// Converts this [Todo] into a [JsonMap].
  JsonMap toJson() => _$TodoToJson(this);

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
