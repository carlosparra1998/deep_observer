import 'package:deep_observer/src/core/injection/deep_provider.dart';
import 'package:flutter/material.dart';

class GlobalInjector<T> extends StatelessWidget {
  final List<T Function()> registrations;
  final Widget child;

  const GlobalInjector({
    super.key,
    required this.registrations,
    required this.child,
  });

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
