import 'package:deep_observer/deep_observer.dart';

class MyCounterProvider {
  List<DeepObservable<int>> counters = List.generate(
    5,
    (_) => DeepObservable(0),
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
