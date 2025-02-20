import 'package:flutter/material.dart';

class LocalInjector<T> extends StatelessWidget {
  final T Function() registration;
  final Widget Function(BuildContext context, T provider) builder;

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
