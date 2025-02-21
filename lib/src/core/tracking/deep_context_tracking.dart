import 'package:deep_observer/src/deep_observable.dart';
import 'package:flutter/material.dart';

/// Clase privada que gestiona la reactividad de los observables creados en toda la app.
class DeepContextTracking {

  /// Variable [Map] que contiene los observables por cada `context`.
  static final Map<BuildContext, Set<DeepObservable>> _dependencies = {};

  /// Actualizará los `context` dado un [DeepObservable].
  static void updateDependency(DeepObservable observable) {
    _clean();
    List<BuildContext> updateContexts =
        _dependencies.keys
            .where((key) => _dependencies[key]?.contains(observable) ?? false)
            .toList();
    _updateContexts(updateContexts.toSet(), observable.efficiencyMode);
  }

  /// Registrará el [DeepObservable] en las dependencias reactivas dado el `context`.
  static void registerDependencies(
    BuildContext context,
    List<DeepObservable> observables,
  ) {
    _clean();
    _dependencies.putIfAbsent(context, () => {});
    _dependencies[context]?.addAll(observables);
  }

  /// Eliminará aquellos `context` que han sido desmontados.
  static void _clean() {
    _dependencies.removeWhere((ctx, _) => !(ctx as Element).mounted);
  }

  /// Algoritmo para actualizar eficientemente los `context` que corresponden.
  static void _updateContexts(
    Set<BuildContext> updateContexts,
    bool efficiencyMode,
  ) {
    for (var context in updateContexts) {
      if (!efficiencyMode) {
        (context as Element).markNeedsBuild();
        continue;
      }
      bool update = true;
      context.visitAncestorElements((ancestor) {
        if (updateContexts.contains(ancestor)) {
          update = false;
          return false;
        }
        return true;
      });
      if (update) {
        (context as Element).markNeedsBuild();
      }
    }
  }
}
