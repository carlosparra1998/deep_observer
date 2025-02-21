import 'package:deep_observer/src/deep_observable.dart';
import 'package:deep_observer/src/core/tracking/deep_context_tracking.dart';
import 'package:flutter/material.dart';

/// Este [Widget] [DeepUpdatable] permitirá controlar la reactividad de tus observables de forma explícita.
/// 
/// Esta clase sustituirá el funcionamiento de:
/// 
/// ```dart
/// //Ejemplo
/// myObservable.reactiveValue(context)
/// ```
class DeepUpdatable extends StatelessWidget {

  /// Este parámetro deberá contener una lista con todos los observables que se quieran controlar explícitamente.
  final List<DeepObservable> registrations;

  /// En este parámetro se construye el [Widget], el cual estará a la escucha de todos los cambios de los observables.
  final Function builder;

  /// Constructor de [DeepUpdatable].
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
