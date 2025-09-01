import 'package:app_core/app_core.dart';

class SampleModel extends BaseObject {
  final String id;
  final String name;
  final String description;

  const SampleModel({required this.id, required this.name, required this.description});

  @override
  List<Object?> get props => [id, name, description];

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }

  factory SampleModel.fromJson(Map<String, dynamic> json) {
    return SampleModel(id: json['id'] as String, name: json['name'] as String, description: json['description'] as String);
  }
}
