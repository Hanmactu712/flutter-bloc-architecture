import 'package:flutter/material.dart';

enum DeviceType {
  compactScreen,
  mediumScreen,
  expandedScreen,
  largeScreen,
  extraLargeScreen,
}

class Device {
  static late double width;
  static late double height;
  static late double aspectRatio;

  static bool get compactScreen => width < 600;
  static bool get mediumScreen => width >= 600 && width < 840;
  static bool get expandedScreen => width >= 840 && width < 1200;
  static bool get largeScreen => width >= 1200 && width < 1600;
  static bool get extraLargeScreen => width >= 1600;

  static bool get compactHeightScreen => height < 600;
  static bool get mediumHeightScreen => height >= 600 && height < 960;
  static bool get expandedHeightScreen => height >= 960;

  /// Device's BoxConstraints
  static late BoxConstraints constraints;

  /// Device's Orientation
  static Orientation orientation = Orientation.portrait;

  static DeviceType get deviceType {
    if (compactScreen) {
      return DeviceType.compactScreen;
    } else if (mediumScreen) {
      return DeviceType.mediumScreen;
    } else if (expandedScreen) {
      return DeviceType.expandedScreen;
    } else if (largeScreen) {
      return DeviceType.largeScreen;
    } else {
      return DeviceType.extraLargeScreen;
    }
  }

  static DeviceType? currentDeviceType;

  static bool setDeviceDimension({
    required BoxConstraints constraints,
    required Orientation orientation,
  }) {
    Device.width = constraints.maxWidth;
    Device.height = constraints.maxHeight;
    Device.aspectRatio = constraints.constrainDimensions(width, height).aspectRatio;
    Device.constraints = constraints;

    //if the type of screen is changed, return true
    var isChanged = false;
    var newDeviceType = deviceType;
    if (newDeviceType != currentDeviceType) {
      currentDeviceType = newDeviceType;
      isChanged = true;
    }
    if (Device.orientation != orientation) {
      Device.orientation = orientation;
      isChanged = true;
    }

    return isChanged;
  }
}
