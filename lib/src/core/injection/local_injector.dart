import 'package:flutter/material.dart';

/// This [Widget] [LocalInjector] will allow you to create unique instances of your provider class within the generated `context`.
class LocalInjector<T> extends StatelessWidget {
  /// This parameter must contain the creation of the provider class instance.
  final T Function() registration;

  /// In this parameter the [Widget] is built with the instance created.
  final Widget Function(BuildContext context, T provider) builder;

  /// [LocalInjector] constructor.
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
