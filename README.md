# Deep Observer
[<img src="https://raw.githubusercontent.com/rrousselGit/provider/master/resources/flutter_favorite.png" width="200" />](https://flutter.dev/docs/development/packages-and-plugins/favorites)

Librería que permite una gestión sencilla, y eficiente de los estados de la aplicación.

Utilizando `Deep Observable` podrás:

- Manejar la reactividad de tu aplicación de forma sencilla.
- **Gestión implícita**, la cual te permite manejar la reactividad a partir de las propias variables, sin necesidad de incluir Wraps innecesarios en tu código.
- **Modo eficiencia** (Experimental), en donde se realizarán los renderizados mínimos necesarios para controlar la reactividad, evitando actualizaciones recurrentes e innecesarias.

## Usage

Vamos a ver los pasos detallados para el uso adecuado de Deep Observer.

---

### Paso 1. Creación de Observers.

Lo primero será crear una clase que consideréis como `provider`, sin embargo, no tiene que tener ninguna extensión con `ChangeNotifier`.

Una vez creado, podemos declarar variables de tipo `DeepObservable`, estas contendrán las propiedades necesarias para la reactividad.

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

Para usar tus clases `provider` con variables `DeepObservable` adecuadamente, se deberá realizar previamente una inyección de dependencias. Se pueden realizar de dos maneras diferentes.

#### Método 1. Inyección global

Para realizar una inyeción de dependencias global, lo ideal será envolver `MaterialApp` con `GlobalInjector`, indicando en *registrations* las clases `provider` a utilizar. Estarán disponibles desde cualquier punto de la aplicación.

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalInjector(
      registrations: [
        () => MyCounterProvider(),
        () => LoginProvider(),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomeView(),
      ),
    );
  }
}
```

#### Método 2. Inyección local

Para realizar una inyeción de dependencias local, simplemente se envuelve cualquier Widget con `LocalInjector`, indicando en *registration* la clase `provider` a utilizar. Estará solamente para los Widget hijos de `LocalInjector`.

```dart
class _MyRowCounterState extends State<MyRowCounter> {
  @override
  Widget build(BuildContext context) {
    return LocalInjector(
      registration: () => MyCounterProvider(),
      builder: (BuildContext context, MyCounterProvider provider) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Counter ${provider.counter.value}:',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### Paso 3. Gestión de estados

En este punto se va a detallar como gestionar la reactividad con todo lo anterior establecido. Para ello podemos utilizar dos métodos.

#### Método 1. Gestión implícita (Deep gesture) **{NUEVO}**

Lo primero que debemos hacer es obtener la instancia de nuestra clase `provider`.

Podemos hacerlo con el método `context.deepGet<MyCounterProvider>()`. 

En caso de haber realizado una inyección local de dependencias, podemos obtener la instancia del `builder` de `LocalInjector`. 

(TEST ESTO ?????)

Para la gestión implícita, basta con obtener el valor deseado del `DeepObservable` mediante `observable.reactiveValue(context)`.

Con esto, el `context` pasado por parámetro se suscribirá automáticamente a los cambios del `DeepObservable`. En caso de haber algún cambio, o actualización, solo se renderizarán los Widgets que estén dentro del árbol generado por ese `context`.

```dart

class _MyRowCounterState extends State<MyRowCounter> {
  @override
  Widget build(BuildContext context) {
    MyCounterProvider provider = context.deepGet<MyCounterProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Counter ${widget.identifier + 1}:',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Text(
                '${widget.observable.reactiveValue(context)}', //DEEP GESTURE
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              MyIconButton(
                Icons.add,
                onTap: () {
                  provider.incrementCounter(widget.identifier);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

#### Método 2. Gestión explícita (Gestión clásica) 

Al igual que en la gestión implícita, Lo primero que debemos hacer es obtener la instancia de nuestra clase `provider`.

Podemos hacerlo con el método `context.deepGet<MyCounterProvider>()`. 

En caso de haber realizado una inyección local de dependencias, podemos obtener la instancia del `builder` de `LocalInjector`. Pero el Widget `DeepUpdatable` debe estar obligatoriamente dentro del árbol de `LocalInjector` en este caso.

(TEST ESTO ?????)

Para la gestión explícita, debemos de envolver los Widgets con `DeepUpdatable`. En *registrations* podemos indicar un número cualquiera de clases `provider`. El builder contendrá (N + 1) parámetros, siendo N el número de providers indicados en *registrations*. El primer parámetro será un `context`.

El `context` generado por `DeepUpdatable` se suscribirá automáticamente a los cambios de los `DeepObservable`. En caso de haber algún cambio, o actualización, solo se renderizará, los Widgets que estén dentro del árbol generado por ese `context`.

```dart
class _MyRowCounterState extends State<MyRowCounter> {
  @override
  Widget build(BuildContext context) {
    MyCounterProvider provider = context.deepGet<MyCounterProvider>();

    return DeepUpdatable(  //EXPLICIT GESTURE
      registrations: [provider.counter],
      builder:
          (BuildContext context, DeepObservable<int> counter) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Counter ${widget.identifier + 1}:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      '${widget.observable.value}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    MyIconButton(
                      Icons.add,
                      onTap: () {
                        provider.incrementCounter(widget.identifier);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
```

---

## ANEXO 1. Modo eficiencia (Experimental)
```dart
class HomeController{
  HomeController();

  DeepObservable<int> observableInt = DeepObservable(0, efficiencyMode: true);

  DeepObservable<bool?> observableBool = DeepObservable(null, efficiencyMode: true);

  DeepObservable<List<String>> observableList = DeepObservable(<String>[], efficiencyMode: true);
}
```
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
        </tr>
        <tr>
            <td style="text-align: center">
                <a href="https://bloclibrary.dev/tutorials/github-search">
                    <img src="https://raw.githubusercontent.com/felangel/bloc/master/assets/examples/flutter_github_search.gif" width="200"/>
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

- [Multi Counter - Implicit Gesture](https://bloclibrary.dev/tutorials/flutter-counter) - an example of how to create a `CounterBloc` to implement the classic Flutter Counter app.
- [Multi Counter - Explicit Gesture](https://github.com/felangel/bloc/tree/master/examples/flutter_form_validation) - an example of how to use the `bloc` and `flutter_bloc` packages to implement form validation.

## Maintainers

- [Carlos Francisco Parra García](https://github.com/carlosparra1998)