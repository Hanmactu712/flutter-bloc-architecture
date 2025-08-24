import 'abstract_sample_service.dart';

class SampleService implements ISampleService {
  @override
  Future<void> fetchData() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
  }
}
