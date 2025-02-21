import 'package:deep_observer/src/deep_observable.dart';
import 'package:deep_observer/src/core/tracking/deep_context_tracking.dart';
import 'package:flutter/material.dart';

/// This [Widget] [DeepUpdatable] will allow you to control the reactivity of your observables explicitly.
/// 
/// This class will replace the operation of:
/// 
/// ```dart
/// //Example
/// myObservable.reactiveValue(context)
/// ```
class DeepUpdatable extends StatelessWidget {

  /// This parameter should contain a list of all the observables to be explicitly controlled.
  final List<DeepObservable> registrations;

  /// In this parameter the [Widget] is built, which will listen to all the changes of the observables.
  final Function builder;

  /// [DeepUpdatable] constructor.
  const DeepUpdatable({
    super.key,
    required this.registrations,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    DeepContextTracking.registerDependencies(context, registrations);
    return Function.apply(
      builder,
      [context, ...registrations.map((e) => e.value)],
    ) as Widget;
  }
}
