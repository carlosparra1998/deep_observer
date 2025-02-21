import 'package:flutter/material.dart';

/// Este [Widget] [LocalInjector] permitirá crear instancias únicas de tu clase provider dentro del `context` generado.
class LocalInjector<T> extends StatelessWidget {

  /// Este parámetro deberá contener la creación de la instancia de la clase provider.
  final T Function() registration;

  /// En este parámetro se construye el [Widget] con la instancia creada.
  final Widget Function(BuildContext context, T provider) builder;

  /// Constructor de [LocalInjector].
  const LocalInjector({
    super.key,
    required this.registration,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, registration());
  }
}
