import 'package:deep_observer/src/core/injection/deep_provider.dart';
import 'package:flutter/material.dart';

/// This [Widget] [GlobalInjector] will allow you to create unique instances of your provider classes throughout the app.
/// 
/// It is recommended that this [Widget] should wrap [MaterialApp].
class GlobalInjector<T> extends StatelessWidget {

  /// This parameter must contain the creation of each instance of the provider classes to be used.
  final List<T Function()> registrations;

  /// The child [Widget] will be included in this parameter.
  final Widget child;

  /// [GlobalInjector] constructor.
  const GlobalInjector({
    super.key,
    required this.registrations,
    required this.child,
  });

  /// This parameter will include all the dependencies created, indicated in `registrations`.
  static final Map<Type, dynamic> _dependencies = {};

  @override
  Widget build(BuildContext context) {
    for (var factory in registrations) {
      T object = factory();
      if (!_dependencies.containsKey(object.runtimeType)) {
        _dependencies[object.runtimeType] = object;
      }
    }

    return DeepProvider(
      dependencies: _dependencies,
      child: child,
    );
  }
}
