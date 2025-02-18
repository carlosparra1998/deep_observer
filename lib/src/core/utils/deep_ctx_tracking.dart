import 'package:flutter/material.dart';

import '../deep_observer_core.dart';

class DeepContextTracking {
  static final Map<BuildContext, Set<DeepObserver>> _dependencies = {};

  static void registerDependency(
    BuildContext context,
    DeepObserver observable,
  ) {
    _clean();

    _dependencies.putIfAbsent(context, () => {});

    if (!_dependencies[context]!.add(observable)) {
      return;
    }

    observable.addListener(() {
      if ((context as Element).mounted) {
        context.markNeedsBuild();
      }
    });
  }

  static void _clean() {
    _dependencies.removeWhere((ctx, _) => !(ctx as Element).mounted);
  }
}
