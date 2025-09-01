import 'dart:math';

import 'package:sample_package_structure/sample_package_structure.dart';

class SampleService implements ISampleService {
  @override
  Future<List<SampleModel>> fetchData({int fromIndex = 0}) async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));

    //return random 5 items
    return List.generate(10, (index) {
      return SampleModel(id: '${fromIndex + index}', name: 'Sample ${fromIndex + index}', description: 'Description ${fromIndex + index}');
    });
  }
}
