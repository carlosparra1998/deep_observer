import 'package:deep_observer/src/core/tracking/deep_context_tracking.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// Creates a new instance of the Uuid class.
/// Optionally you can pass in a [GlobalOptions] object to set global options
/// for all UUID generation.
/// [GlobalOptions.rng] is a [RNG] class that returns a list of random bytes.
///
/// Defaults rng function is `UuidUtil.cryptoRNG`
///
/// Example: Using MathRNG globally
///
/// ```dart
/// var uuid = Uuid(options: {
///   'grng': UuidUtil.mathRNG
/// })
///
/// // Generate a v4 (random) id that will use cryptRNG for its rng function
/// uuid.v4();
/// ```
class DeepObservable<T> {
  late final String _uuid;

  bool _lockReactivity = false;

  T _value;

  late T _defaultValue;

  T get value => _value;

  T reactiveValue(BuildContext context) {
    DeepContextTracking.registerDependencies(context, [this]);
    return _value;
  }

  set value(T value) => set(value);

  DeepObservable(this._value) {
    _defaultValue = _value;
    _uuid = const Uuid().v4();
  }

  void set(T value) {
    if (value != _value) {
      _value = value;
      update();
    }
  }

  void reset() {
    if (_defaultValue != _value) {
      _value = _defaultValue;
      update();
    }
  }

  void update() {
    if (!_lockReactivity) {
      DeepContextTracking.updateDependency(this);
    }
  }

  void lockReactivity() {
    _lockReactivity = true;
  }

  void unlockReactivity() {
    _lockReactivity = false;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeepObservable &&
          runtimeType == other.runtimeType &&
          _uuid == other._uuid);

  @override
  int get hashCode => _uuid.hashCode;
}
