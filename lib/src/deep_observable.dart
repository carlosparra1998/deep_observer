import 'package:deep_observer/src/core/tracking/deep_context_tracking.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// Creas una nueva instancia de la clase [DeepObservable].
/// Esta variable contendrá unas propiedades que permitirán gestionar sencillamente la reactividad en tu código.
/// 
/// Podrás elegir cualquier tipo de variable.
///
/// ```dart
/// //Ejemplo
/// DeepObservable<double> myObservable = DeepObservable(0.0);
/// ```
/// 
/// Podrás acceder a estos observables desde cualquier parte.
/// 
/// ```dart
/// //Ejemplo
/// YourProvider provider = context.deepObs<YourProvider>();
/// ```
/// 
/// Podrás obtener el valor directo del observable.
/// 
/// ```dart
/// //Ejemplo
/// double myValue = provider.myObservable.value;
/// ```
/// 
/// También podrás obtener el valor reactivo del mismo. 
/// Esto permitirá actualizar automáticamente los [Widget] que solamente contengan ese `context` en caso de que aparezcan cambios en el observable,
/// esto sin necesidad de indicarlo explícitamente con un [Wrap] como [Consumer]. 
/// 
/// Al renderizar solamente los [Widget] afectados por ese `context`, 
/// se incrementa la eficiencia en la gestión de estados. La suscripción a los cambios es implícita.
/// 
/// ```dart
/// //Ejemplo
/// double myValue = provider.myObservable.reactiveValue(context);
/// ```
/// 
/// Podrás forzar una actualización del mismo en cualquier momento.
/// 
/// ```dart
/// //Ejemplo
/// provider.myObservable.update();
/// ```
class DeepObservable<T> {

  /// Identificador de la instancia [DeepObservable].
  late final String _uuid;

  /// Controlará la reactividad de la instancia [DeepObservable].
  bool _lockReactivity = false;

  ///Valor actual de la instancia [DeepObservable].
  T _value;

  ///Valor inicial de la instancia [DeepObservable].
  late T _defaultValue;

  /// Podrás elegir este método de reactividad, esto evitará renderizados de Widgets innecesarios. Siendo así todavía más eficiente la gestión de estados.
  /// 
  /// Por defecto, este valor estará a `false`.
  /// 
  /// PRECAUCIÓN: Si se utiliza este modo, evitar utilizar el modificador `const` en los [Widget] que contengan internamente declaraciones a `reactiveValue(context)` o al [Widget] `DeepUpdatable`. 
  /// En caso contrario, no se recibirán actualizaciones de los observables dentro de ese [Widget] con `const`.
  /// 
  /// ```dart
  /// //Ejemplo
  /// DeepObservable<double> myObservable = DeepObservable(0.0, efficiencyMode: true);
  /// ```
  final bool efficiencyMode;

  /// Podrás obtener el valor directo del observable.
  /// 
  /// ```dart
  /// //Ejemplo
  /// double myValue = provider.myObservable.value;
  /// ```
  T get value => _value;

  /// Podrás obtener el valor reactivo del mismo.
  /// 
  /// Esto permitirá actualizar automáticamente los [Widget] que solamente contengan ese `context` en caso de que aparezcan cambios en el observable,
  /// esto sin necesidad de indicarlo explícitamente con un [Wrap]. 
  /// 
  /// Al renderizar solamente los [Widget] afectados por ese `context`, 
  /// se incrementa la eficiencia en la gestión de estados. La suscripción a los cambios es implícita.
  /// 
  /// ```dart
  /// //Ejemplo
  /// double myValue = provider.myObservable.reactiveValue(context);
  /// ```
  T reactiveValue(BuildContext context) {
    DeepContextTracking.registerDependencies(context, [this]);
    return _value;
  }

  /// Podrás modificar el valor del observable en cualquier momento.
  /// 
  /// Automáticamente se actualizarán los `context` implicados.
  ///
  /// ```dart
  /// //Ejemplo
  /// provider.myObservable.value = 25.5;
  /// ```  
  set value(T value) => set(value);

  /// Construcción de la instancia de [DeepObservable].
  DeepObservable(this._value, {this.efficiencyMode = false}) {
    _defaultValue = _value;
    _uuid = const Uuid().v4();
  }

  /// Podrás modificar el valor del observable en cualquier momento.
  /// 
  /// Automáticamente se actualizarán los `context` implicados.
  ///
  /// ```dart
  /// //Ejemplo
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
  /// Automáticamente se actualizarán los `context` implicados.
  /// 
  /// ```dart
  /// //Ejemplo
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

  /// Podrás forzar la actualización los `context` implicados.
  ///
  /// ```dart
  /// //Ejemplo
  /// provider.myObservable.update();
  /// ```  
  void update() {
    if (!_lockReactivity) {
      DeepContextTracking.updateDependency(this);
    }
  }

  /// Podrás bloquear la reactividad del observable.
  /// 
  /// No se actualizarán los `context` implicados.
  ///
  /// ```dart
  /// //Ejemplo
  /// provider.myObservable.lockReactivity();
  /// ```  
  void lockReactivity() {
    _lockReactivity = true;
  }

  /// Podrás desbloquearán la reactividad del observable.
  /// 
  /// Se podrán actualizarán los `context` implicados.
  ///
  /// ```dart
  /// //Ejemplo
  /// provider.myObservable.unlockReactivity();
  /// ```  
  void unlockReactivity() {
    _lockReactivity = false;
  }

  ///Operador `==` para las instancias de [DeepObservable].
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeepObservable &&
          runtimeType == other.runtimeType &&
          _uuid == other._uuid);

  ///HashCode de las instancias de [DeepObservable].
  @override
  int get hashCode => _uuid.hashCode;
}
