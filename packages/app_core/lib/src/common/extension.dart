import 'device.dart';

extension DeviceExt on num {
  double get w => Device.width / 100 * this;
  double get h => Device.height / 100 * this;
}
