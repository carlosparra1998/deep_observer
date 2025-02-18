import 'package:flutter/material.dart';

abstract class IDeepObserver<T> {
  T get valueNoReactive;

  T value(BuildContext context);

  void set(T newValue);

  void update();
}