import 'package:equatable/equatable.dart';

abstract class BaseObject extends Equatable {
  Map<String, dynamic> toJson();
  const BaseObject();
}
