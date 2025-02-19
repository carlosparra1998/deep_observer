import 'package:deep_observer/src/core/injection/deep_provider.dart';
import 'package:flutter/material.dart';

extension DeepContext on BuildContext {
  T deepGet<T>() {
    return DeepProvider.get<T>(this);
  }
}
