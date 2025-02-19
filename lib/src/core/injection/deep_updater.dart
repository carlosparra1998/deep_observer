import 'package:deep_observer/src/deep_observable.dart';
import 'package:deep_observer/src/core/tracking/deep_context_tracking.dart';
import 'package:flutter/material.dart';

class DeepUpdatable extends StatelessWidget {
  final List<DeepObservable> registrations;
  final Function builder;

  const DeepUpdatable({
    super.key,
    required this.registrations,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    DeepContextTracking.registerDependency(context, registrations);
    return Function.apply(
      builder,
      [context, ...registrations.map((e) => e.value)],
    ) as Widget;
  }
}
