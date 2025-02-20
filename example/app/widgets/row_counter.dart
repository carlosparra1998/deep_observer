import 'package:deep_observer/deep_observer.dart';
import '../controllers/counter_provider.dart';
import 'icon_button.dart';
import 'package:flutter/material.dart';

class MyRowCounter extends StatefulWidget {
  final int identifier;
  final DeepObservable observable;

  const MyRowCounter({
    required this.identifier,
    required this.observable,
    super.key,
  });

  @override
  State<MyRowCounter> createState() => _MyRowCounterState();
}

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
                '${widget.observable.reactiveValue(context)}',
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
