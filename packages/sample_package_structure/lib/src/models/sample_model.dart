import 'package:app_core/app_core.dart';

class SampleModel extends BaseObject {
  final String id;
  final String name;

  const SampleModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  factory SampleModel.fromJson(Map<String, dynamic> json) {
    return SampleModel(id: json['id'] as String, name: json['name'] as String);
  }
}
