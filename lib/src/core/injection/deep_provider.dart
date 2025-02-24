import 'package:flutter/material.dart';

/// This [Widget] [DeepProvider] will control all unique instances of the provider classes.
class DeepProvider extends InheritedWidget {
  /// All instances of the provider classes indicated in [LocalInjector] or [GlobalInjector].
  final Map<Type, dynamic> _dependencies;

  /// [DeepProvider] constructor.
  const DeepProvider({
    super.key,
    required Map<Type, dynamic> dependencies,
    required super.child,
  }) : _dependencies = dependencies;

  /// You will be able to get the instance of your provider class through the `context` tree.
  ///
  /// Only in case it is instantiated by [LocalInjector] or [GlobalInjector].
  ///
  /// ```dart
  /// //Example
  /// DeepProvider.get<MyProvider>(context);
  /// ```
  ///
  /// It is the same operation:
  ///
  /// ```dart
  /// //Example
  /// context.deepGet<MyProvider>();
  /// ```
  static T get<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<DeepProvider>();
    final dependency = provider?._dependencies[T];
    if (dependency == null) {
      throw Exception(
        "Deep Observable Error: Dependency not registered for the type: $T",
      );
    }
    return dependency;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
