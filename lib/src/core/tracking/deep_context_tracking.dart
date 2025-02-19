import 'package:deep_observer/src/deep_observable.dart';
import 'package:flutter/material.dart';

class DeepContextTracking {
  static final Map<BuildContext, Set<DeepObservable>> _dependencies = {};

  static void updateDependency(DeepObservable observable) {
    _clean();
    List<BuildContext> updateContexts = _dependencies.keys
        .where((key) => _dependencies[key]?.contains(observable) ?? false)
        .toList();
    _updateContexts(updateContexts.toSet());
  }

  static void registerDependency(
    BuildContext context,
    List<DeepObservable> observables,
  ) {
    _clean();
    _dependencies.putIfAbsent(context, () => {});
    _dependencies[context]?.addAll(observables);
  }

  static void _clean() {
    _dependencies.removeWhere((ctx, _) => !(ctx as Element).mounted);
  }

  static void _updateContexts(Set<BuildContext> updateContexts) {
    for (var context in updateContexts) {
      bool update = true;
      context.visitAncestorElements(
        (ancestor) {
          if (updateContexts.contains(ancestor)) {
            update = false;
            return false;
          }
          return true;
        },
      );
      if (update) {
        (context as Element).markNeedsBuild();
      }
    }
  }

  static void _updateContextsCacheSystem(Set<BuildContext> updateContexts) {
    Set<BuildContext> ancestorsCache = {};
    for (var context in updateContexts) {
      bool update = true;
      context.visitAncestorElements(
        (ancestor) {
          if (ancestorsCache.contains(ancestor) ||
              updateContexts.contains(ancestor)) {
            update = false;
            return false;
          }
          ancestorsCache.add(ancestor);
          return true;
        },
      );
      if (update) {
        (context as Element).markNeedsBuild();
      }
    }
  }
}
