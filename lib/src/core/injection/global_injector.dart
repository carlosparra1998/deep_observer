import 'package:deep_observer/src/core/injection/deep_provider.dart';
import 'package:flutter/material.dart';

/// Este [Widget] [GlobalInjector] permitirá crear instancias únicas de tus clases provider en toda la app.
/// 
/// Lo recomendable es que este [Widget] envuelva a [MaterialApp].
class GlobalInjector<T> extends StatelessWidget {

  /// Este parámetro deberá contener la creación de cada instancia a utilizar de las clases provider.
  final List<T Function()> registrations;

  /// En este parámetro se incluirá el [Widget] hijo.
  final Widget child;

  /// Constructor de [GlobalInjector].
  const GlobalInjector({
    super.key,
    required this.registrations,
    required this.child,
  });

  /// En este parámetro se incluirán todas las dependencias creadas, indicadas en `registrations`.
  static final Map<Type, dynamic> _dependencies = {};

  @override
  Widget build(BuildContext context) {
    for (var factory in registrations) {
      T object = factory();
      if (!_dependencies.containsKey(object.runtimeType)) {
        _dependencies[object.runtimeType] = object;
      }
    }

    return DeepProvider(
      dependencies: _dependencies,
      child: child,
    );
  }
}
