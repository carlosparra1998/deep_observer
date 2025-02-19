import 'package:flutter/material.dart';

class DeepProvider extends InheritedWidget {
  final Map<Type, dynamic> dependencies;

  const DeepProvider({
    super.key,
    required this.dependencies,
    required super.child,
  });

  static T get<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DeepProvider>();
    final dependency = provider?.dependencies[T];
    if (dependency == null) {
      throw Exception("Dependencia no registrada para el tipo: $T");
    }
    return dependency;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
