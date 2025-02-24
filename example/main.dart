import 'package:deep_observer/deep_observer.dart';
import 'package:flutter/material.dart';
import 'app/widgets/icon_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalInjector(
      registrations: [() => MyCounterProvider()],
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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    MyCounterProvider provider = context.deepGet<MyCounterProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Deep Observer', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(provider.counters.length, (ix) {
            return MyRowCounter(identifier: ix);
          }),
        ),
      ),
    );
  }
}

class MyRowCounter extends StatefulWidget {
  final int identifier;

  const MyRowCounter({required this.identifier, super.key});

  @override
  State<MyRowCounter> createState() => _MyRowCounterState();
}

class _MyRowCounterState extends State<MyRowCounter> {
  @override
  Widget build(BuildContext context) {
    MyCounterProvider provider = context.deepGet<MyCounterProvider>();
    DeepObservable<int> observable = provider.counters[widget.identifier];

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
                '${observable.reactiveValue(context)}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Row(
                children: [
                  MyIconButton(
                    Icons.remove,
                    onTap: () {
                      provider.decrementCounter(widget.identifier);
                    },
                  ),
                  SizedBox(width: 10),
                  MyIconButton(
                    Icons.add,
                    onTap: () {
                      provider.incrementCounter(widget.identifier);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCounterProvider {
  List<DeepObservable<int>> counters = List.generate(
    5,
    (_) => DeepObservable(0, efficiencyMode: true),
  );

  DeepObservable<int>? counter(int position) =>
      position >= counters.length ? null : counters[position];

  void incrementCounter(int position) {
    if (position >= counters.length) {
      return;
    }
    counters[position].set(counters[position].value + 1);
  }

  void decrementCounter(int position) {
    if (position >= counters.length || counters[position].value == 0) {
      return;
    }
    counters[position].set(counters[position].value - 1);
  }
}
