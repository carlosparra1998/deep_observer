import 'package:deep_observer/src/core/injection/deep_provider.dart';
import 'package:flutter/material.dart';

/// This extension [DeepContext] will provide methods for managing instances of the provider classes.
extension DeepContext on BuildContext {

  /// You will be able to get the instance of your provider class through the `context` tree.
  /// 
  /// Only in case it is instantiated by [LocalInjector] or [GlobalInjector].
  /// 
  /// ```dart
  /// //Example
  /// context.deepGet<MyProvider>();
  /// ```
  /// 
  /// It is the same operation:
  /// 
  /// ```dart
  /// //Example
  /// DeepProvider.get<MyProvider>(context);
  /// ```
  T deepGet<T>() {
    return DeepProvider.get<T>(this);
  }
}
