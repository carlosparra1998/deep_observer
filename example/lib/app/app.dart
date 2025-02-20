import 'package:deep_observer/deep_observer.dart';
import 'package:example/app/controllers/counter_provider.dart';
import 'package:example/app/views/home_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DeepGlobalInjector(
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
