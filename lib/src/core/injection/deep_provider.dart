import 'package:flutter/material.dart';

/// Este [Widget] [DeepProvider] controlará todas las instancias únicas de las clases provider.
class DeepProvider extends InheritedWidget {

  /// Todas las instancias de las clases provider indicadas en [LocalInjector] o [GlobalInjector].
  final Map<Type, dynamic> _dependencies;

  /// Constructor de [DeepProvider].
  const DeepProvider({
    super.key,
    required Map<Type, dynamic> dependencies,
    required super.child,
  }) : _dependencies = dependencies;

  /// Podrás obtener la instancia de tu clase provider mediante el árbol de `context`.
  /// 
  /// Solo en el caso de que esté instanciado por [LocalInjector] o [GlobalInjector].
  /// 
  /// ```dart
  /// //Ejemplo
  /// DeepProvider.get<MyProvider>(context);
  /// ```
  /// 
  /// Es la misma operación:
  /// 
  /// ```dart
  /// //Ejemplo
  /// context.deepGet<MyProvider>();
  /// ```
  static T get<T>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DeepProvider>();
    final dependency = provider?._dependencies[T];
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
