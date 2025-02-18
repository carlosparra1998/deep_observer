import 'package:flutter/material.dart';

import 'deep_provider.dart';

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

    return DependencyProvider(
      dependencies: _dependencies,
      child: child,
    );
  }
}
