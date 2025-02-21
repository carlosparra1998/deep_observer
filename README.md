# Deep Observer
[<img src="https://raw.githubusercontent.com/rrousselGit/provider/master/resources/flutter_favorite.png" width="200" />](https://flutter.dev/docs/development/packages-and-plugins/favorites)

A wrapper around [InheritedWidget]
to make them easier to use and more reusable.

By using `provider` instead of manually writing [InheritedWidget], you get:

- simplified allocation/disposal of resources
- lazy-loading
- a vastly reduced boilerplate over making a new class every time
- devtool friendly – using Provider, the state of your application will be visible in the Flutter devtool
- a common way to consume these [InheritedWidget]s (See [Provider.of]/[Consumer]/[Selector])
- increased scalability for classes with a listening mechanism that grows exponentially
  in complexity (such as [ChangeNotifier], which is O(N) for dispatching notifications).

To read more about a `provider`, see its [documentation](https://pub.dev/documentation/provider/latest/provider/provider-library.html).


## Usage

Vamos a ver los pasos detallados para el uso adecuado de Deep Observer.

---

### Paso 1. Creación de Observers.

Lo primero será declarar en una clase que consideréis como `provider`, sin embargo, no tiene que tener ninguna extensión con `ChangeNotifier`.

Una vez creado, podemos declarar variables de tipo `DeepObservable` para que estas tengan las propiedades necesarias para la reactividad.

Se debe indicar el tipo de dato a manejar, y el valor que tendrá inicialmente.

```dart
class HomeController{
  HomeController();

  DeepObservable<int> observableInt = DeepObservable(0);

  DeepObservable<bool?> observableBool = DeepObservable(null);

  DeepObservable<List<String>> observableList = DeepObservable(<String>[]);
}
```
---

### Paso 2. Inyección de dependencias

Lo primero será declarar en una clase que consideréis como `provider`, sin embargo, no tiene que tener ninguna extensión con `ChangeNotifier`.

#### Método 1. Inyección global

Lo primero será declarar en una clase que consideréis como `provider`, sin embargo, no tiene que tener ninguna extensión con `ChangeNotifier`.

```dart

void main() => runApp(CounterApp());
class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: CounterPage(),
      ),
    );
  }
}
```

#### Método 2. Inyección local

Lo primero será declarar en una clase que consideréis como `provider`, sin embargo, no tiene que tener ninguna extensión con `ChangeNotifier`.

```dart
void main() => runApp(CounterApp());
class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: CounterPage(),
      ),
    );
  }
}
```

---

### Paso 3. Gestión de estados

Lo primero será declarar en una clase que consideréis como `provider`, sin embargo, no tiene que tener ninguna extensión con `ChangeNotifier`.

#### Método 1. Gestión implícita

Lo primero será declarar en una clase que consideréis como `provider`, sin embargo, no tiene que tener ninguna extensión con `ChangeNotifier`.

```dart

void main() => runApp(CounterApp());
class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: CounterPage(),
      ),
    );
  }
}
```

#### Método 2. Gestión explícita

Lo primero será declarar en una clase que consideréis como `provider`, sin embargo, no tiene que tener ninguna extensión con `ChangeNotifier`.

```dart
void main() => runApp(CounterApp());
class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: CounterPage(),
      ),
    );
  }
}
```

---

## ANEXO 1. Modo eficiente

**BlocBuilder** is a Flutter widget which requires a `bloc` and a `builder` function. `BlocBuilder` handles building the widget in response to new states. `BlocBuilder` is very similar to `StreamBuilder` but has a more simple API to reduce the amount of boilerplate code needed. The `builder` function will potentially be called many times and should be a [pure function](https://en.wikipedia.org/wiki/Pure_function) that returns a widget in response to the state.

See `BlocListener` if you want to "do" anything in response to state changes such as navigation, showing a dialog, etc...

If the `bloc` parameter is omitted, `BlocBuilder` will automatically perform a lookup using `BlocProvider` and the current `BuildContext`.

```dart
BlocBuilder<BlocA, BlocAState>(
  builder: (context, state) {
    // return widget here based on BlocA's state
  }
)
```

Only specify the bloc if you wish to provide a bloc that will be scoped to a single widget and isn't accessible via a parent `BlocProvider` and the current `BuildContext`.

```dart
BlocBuilder<BlocA, BlocAState>(
  bloc: blocA, // provide the local bloc instance
  builder: (context, state) {
    // return widget here based on BlocA's state
  }
)
```

**MultiBlocProvider** is a Flutter widget that merges multiple `BlocProvider` widgets into one.
`MultiBlocProvider` improves the readability and eliminates the need to nest multiple `BlocProviders`.
By using `MultiBlocProvider` we can go from:

## Gallery

<div style="text-align: center">
    <table>
        <tr>
            <td style="text-align: center">
                <a href="https://bloclibrary.dev/tutorials/flutter-counter">
                    <img src="https://raw.githubusercontent.com/felangel/bloc/master/assets/examples/flutter_counter.gif" width="200"/>
                </a>
            </td>            
            <td style="text-align: center">
                <a href="https://bloclibrary.dev/tutorials/flutter-infinite-list">
                    <img src="https://raw.githubusercontent.com/felangel/bloc/master/assets/examples/flutter_infinite_list.gif" width="200"/>
                </a>
            </td>
            <td style="text-align: center">
                <a href="https://bloclibrary.dev/tutorials/flutter-login">
                    <img src="https://raw.githubusercontent.com/felangel/bloc/master/assets/examples/flutter_firebase_login.gif" width="200" />
                </a>
            </td>
        </tr>
        <tr>
            <td style="text-align: center">
                <a href="https://bloclibrary.dev/tutorials/github-search">
                    <img src="https://raw.githubusercontent.com/felangel/bloc/master/assets/examples/flutter_github_search.gif" width="200"/>
                </a>
            </td>
            <td style="text-align: center">
                <a href="https://bloclibrary.dev/tutorials/flutter-weather">
                    <img src="https://raw.githubusercontent.com/felangel/bloc/master/assets/examples/flutter_weather.gif" width="200"/>
                </a>
            </td>
            <td style="text-align: center">
                <a href="https://bloclibrary.dev/tutorials/flutter-todos">
                    <img src="https://raw.githubusercontent.com/felangel/bloc/master/assets/examples/flutter_todos.gif" width="200"/>
                </a>
            </td>
        </tr>
    </table>
</div>

## Examples

- [Counter](https://bloclibrary.dev/tutorials/flutter-counter) - an example of how to create a `CounterBloc` to implement the classic Flutter Counter app.
- [Form Validation](https://github.com/felangel/bloc/tree/master/examples/flutter_form_validation) - an example of how to use the `bloc` and `flutter_bloc` packages to implement form validation.
- [Bloc with Stream](https://github.com/felangel/bloc/tree/master/examples/flutter_bloc_with_stream) - an example of how to hook up a `bloc` to a `Stream` and update the UI in response to data from the `Stream`.
- [Complex List](https://github.com/felangel/bloc/tree/master/examples/flutter_complex_list) - an example of how to manage a list of items and asynchronously delete items one at a time using `bloc` and `flutter_bloc`.
- [Infinite List](https://bloclibrary.dev/tutorials/flutter-infinite-list) - an example of how to use the `bloc` and `flutter_bloc` packages to implement an infinite scrolling list.
- [Login Flow](https://bloclibrary.dev/tutorials/flutter-login) - an example of how to use the `bloc` and `flutter_bloc` packages to implement a Login Flow.
- [Firebase Login](https://bloclibrary.dev/tutorials/flutter-firebase-login) - an example of how to use the `bloc` and `flutter_bloc` packages to implement login via Firebase.
- [Github Search](https://bloclibrary.dev/tutorials/github-search) - an example of how to create a Github Search Application using the `bloc` and `flutter_bloc` packages.
- [Weather](https://bloclibrary.dev/tutorials/flutter-weather) - an example of how to create a Weather Application using the `bloc` and `flutter_bloc` packages. The app uses a `RefreshIndicator` to implement "pull-to-refresh" as well as dynamic theming.
- [Todos](https://bloclibrary.dev/tutorials/flutter-todos) - an example of how to create a Todos Application using the `bloc` and `flutter_bloc` packages.
- [Timer](https://bloclibrary.dev/tutorials/flutter-timer) - an example of how to create a Timer using the `bloc` and `flutter_bloc` packages.
- [Shopping Cart](https://github.com/felangel/bloc/tree/master/examples/flutter_shopping_cart) - an example of how to create a Shopping Cart Application using the `bloc` and `flutter_bloc` packages based on [flutter samples](https://github.com/flutter/samples/tree/master/provider_shopper).
- [Dynamic Form](https://github.com/felangel/bloc/tree/master/examples/flutter_dynamic_form) - an example of how to use the `bloc` and `flutter_bloc` packages to implement a dynamic form which pulls data from a repository.
- [Wizard](https://github.com/felangel/bloc/tree/master/examples/flutter_wizard) - an example of how to build a multi-step wizard using the `bloc` and `flutter_bloc` packages.
- [Fluttersaurus](https://github.com/felangel/fluttersaurus) - an example of how to use the `bloc` and `flutter_bloc` packages to create a thesuarus app -- made for Bytconf Flutter 2020.
- [I/O Photo Booth](https://github.com/flutter/photobooth) - an example of how to use the `bloc` and `flutter_bloc` packages to create a virtual photo booth web app -- made for Google I/O 2021.
- [I/O Pinball](https://github.com/flutter/pinball) - an example of how to use the `bloc` and `flutter_bloc` packages to create a pinball web app -- made for Google I/O 2022.

## Dart Versions

- Dart 2: >= 2.14

## Maintainers

- [Felix Angelov](https://github.com/felangel)