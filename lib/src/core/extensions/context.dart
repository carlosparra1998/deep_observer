import 'package:deep_observer/src/core/injection/deep_provider.dart';
import 'package:flutter/material.dart';

/// Esta extensión [DeepContext] facilitará métodos para la gestión de las instancias de las clases provider.
extension DeepContext on BuildContext {

  /// Podrás obtener la instancia de tu clase provider mediante el árbol de `context`.
  /// 
  /// Solo en el caso de que esté instanciado por [LocalInjector] o [GlobalInjector].
  /// 
  /// ```dart
  /// //Ejemplo
  /// context.deepGet<MyProvider>();
  /// ```
  /// 
  /// Es la misma operación:
  /// 
  /// ```dart
  /// //Ejemplo
  /// DeepProvider.get<MyProvider>(context);
  /// ```
  T deepGet<T>() {
    return DeepProvider.get<T>(this);
  }
}
