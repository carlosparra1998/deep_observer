import 'package:deep_observer/src/core/tracking/deep_context_tracking.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// You create a new instance of the [DeepObservable] class.
/// This instance will contain properties that allow you to easily manage reactivity in your code.
/// 
/// You can choose any type of data.
///
/// ```dart
/// //Example
/// DeepObservable<double> myObservable = DeepObservable(0.0);
/// ```
/// 
/// You will be able to access these observables from anywhere.
/// 
/// ```dart
/// //Example
/// YourProvider provider = context.deepObs<YourProvider>();
/// ```
/// 
/// You will be able to obtain the direct value of the observable.
/// 
/// ```dart
/// //Example
/// double myValue = provider.myObservable.value;
/// ```
/// 
/// This will allow to automatically update the [Widget] containing only that `context` in case of changes in the observable, 
/// without the need to explicitly indicate it with a [Wrap] like [Consumer].
/// 
/// By rendering only the [Widget] affected by that `context`, 
/// efficiency in the management of states is increased. Subscription to changes is implicit.
/// 
/// ```dart
/// //Example
/// double myValue = provider.myObservable.reactiveValue(context);
/// ```
/// 
/// You will be able to force an update at any time.
/// 
/// ```dart
/// //Example
/// provider.myObservable.update();
/// ```
class DeepObservable<T> {

  /// Identifier of the [DeepObservable] instance.
  late final String _uuid;

  /// Will control the reactivity of the [DeepObservable] instance.
  bool _lockReactivity = false;

  /// Current value of the [DeepObservable] instance.
  T _value;

  /// Initial value of the [DeepObservable] instance.
  late T _defaultValue;

  /// You can choose this reactivity method, this will avoid unnecessary widget renderings. This will make the state management even more efficient.
  /// 
  /// By default, this value will be set to `false`.
  /// 
  /// CAUTION: If this mode is used, avoid using the `const` modifier on [Widget] containing internally declarations to `reactiveValue(context)` or 
  /// to the [Widget] `DeepUpdatable`. Otherwise, you will not receive updates to observables within that [Widget] with `const`.
  /// 
  /// ```dart
  /// //Example
  /// DeepObservable<double> myObservable = DeepObservable(0.0, efficiencyMode: true);
  /// ```
  final bool efficiencyMode;

  /// You will be able to obtain the direct value of the observable.
  /// 
  /// ```dart
  /// //Example
  /// double myValue = provider.myObservable.value;
  /// ```
  T get value => _value;

  /// You will be able to obtain its reactive value.
  /// 
  /// This will allow to automatically update the [Widget] containing only that `context` in case of changes in the observable, 
  /// without the need to explicitly indicate it with a [Wrap]. 
  /// 
  /// By rendering only the [Widget] affected by that `context`, 
  /// efficiency in the management of states is increased. Subscription to changes is implicit.
  /// 
  /// ```dart
  /// //Example
  /// double myValue = provider.myObservable.reactiveValue(context);
  /// ```
  T reactiveValue(BuildContext context) {
    DeepContextTracking.registerDependencies(context, [this]);
    return _value;
  }

  /// You can change the value of the observable at any time.
  /// 
  /// The `context` involved will be automatically updated.
  ///
  /// ```dart
  /// //Example
  /// provider.myObservable.value = 25.5;
  /// ```  
  set value(T value) => set(value);

  /// Construcción de la instancia de [DeepObservable].
  DeepObservable(this._value, {this.efficiencyMode = false}) {
    _defaultValue = _value;
    _uuid = const Uuid().v4();
  }

  /// You can change the value of the observable at any time.
  /// 
  /// The `context` involved will be automatically updated.
  ///
  /// ```dart
  /// //Example
  /// provider.myObservable.set(25.5);
  /// ```  
  void set(T value) {
    if (value != _value) {
      _value = value;
      update();
    }
  }

  /// Podrás regresar al valor original del observable. 
  /// 
  /// The `context` involved will be automatically updated.
  /// 
  /// ```dart
  /// //Example
  /// DeepObservable<double> myObservable = DeepObservable(10.0);
  /// 
  /// myObservable.set(25.5);
  /// 
  /// print(myObservable.value); //25.5
  /// 
  /// myObservable.reset();
  /// 
  /// print(myObservable.value); //10.0
  /// ```  
  void reset() {
    if (_defaultValue != _value) {
      _value = _defaultValue;
      update();
    }
  }

  /// You will be able to force the update of the `context` involved.
  ///
  /// ```dart
  /// //Example
  /// provider.myObservable.update();
  /// ```  
  void update() {
    if (!_lockReactivity) {
      DeepContextTracking.updateDependency(this);
    }
  }

  /// You will be able to block the reactivity of the observable.
  /// 
  /// The `context` involved will not be updated.
  ///
  /// ```dart
  /// //Example
  /// provider.myObservable.lockReactivity();
  /// ```  
  void lockReactivity() {
    _lockReactivity = true;
  }

  /// You will be able to unlock the reactivity of the observable.
  /// 
  /// The `context` involved can be updated.
  ///
  /// ```dart
  /// //Example
  /// provider.myObservable.unlockReactivity();
  /// ```  
  void unlockReactivity() {
    _lockReactivity = false;
  }

  /// Operator `==` for [DeepObservable] instances.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeepObservable &&
          runtimeType == other.runtimeType &&
          _uuid == other._uuid);

  /// HashCode of [DeepObservable] instances.
  @override
  int get hashCode => _uuid.hashCode;
}
