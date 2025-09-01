import 'package:sample_package_structure/sample_package_structure.dart';

abstract class ISampleService {
  Future<List<SampleModel>> fetchData({int fromIndex = 0});
}
