import 'package:deep_observer/deep_observer.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'utils/deep_ctx_tracking.dart';

class DeepObserver<T> with ChangeNotifier implements IDeepObserver<T> {
  late String _uuid;

  T _value;

  DeepObserver(this._value) {
    _uuid = const Uuid().v4();
  }

  @override
  T get valueNoReactive => _value;

  @override
  T value(BuildContext context) {
    DeepContextTracking.registerDependency(context, this);
    return _value;
  }

  @override
  void set(T value) {
    if (value != _value) {
      _value = value;
      update();
    }
  }

  @override
  void update() {
    notifyListeners();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeepObserver &&
          runtimeType == other.runtimeType &&
          _uuid == other._uuid);

  @override
  int get hashCode => _uuid.hashCode;
}
