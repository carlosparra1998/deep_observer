import 'package:deep_observer/src/deep_observable.dart';
import 'package:flutter/material.dart';

/// Private class that manages the reactivity of the observables created throughout the app.
class DeepContextTracking {

  /// [Map] variable containing the observables for each `context`.
  static final Map<BuildContext, Set<DeepObservable>> _dependencies = {};

  /// It will update the `context` given a [DeepObservable].
  static void updateDependency(DeepObservable observable) {
    _clean();
    List<BuildContext> updateContexts =
        _dependencies.keys
            .where((key) => _dependencies[key]?.contains(observable) ?? false)
            .toList();
    _updateContexts(updateContexts.toSet(), observable.efficiencyMode);
  }

  /// It will register the [DeepObservable] in the reactive dependencies given the `context`.
  static void registerDependencies(
    BuildContext context,
    List<DeepObservable> observables,
  ) {
    _clean();
    _dependencies.putIfAbsent(context, () => {});
    _dependencies[context]?.addAll(observables);
  }

  /// It will remove those `contexts` that have been disassembled.
  static void _clean() {
    _dependencies.removeWhere((ctx, _) => !(ctx as Element).mounted);
  }

  /// Algorithm to efficiently update the corresponding `context`.
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
