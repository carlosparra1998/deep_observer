import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class DependencyProvider extends InheritedWidget {
  final Map<Type, dynamic> dependencies;

  const DependencyProvider({
    super.key,
    required this.dependencies,
    required super.child,
  });

  static T get<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DependencyProvider>();
    final dependency = provider?.dependencies[T];
    if (dependency == null) {
      throw Exception("Dependencia no registrada para el tipo: $T");
    }
    return dependency;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return !const MapEquality()
        .equals(dependencies, (oldWidget as DependencyProvider).dependencies);
  }
}
