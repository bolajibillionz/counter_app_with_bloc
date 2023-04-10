import 'dart:developer';
import 'other_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_app_with_bloc/bloc/counter/counter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyCounter Bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<CounterBloc, CounterState>(
          listener: (context, state) {
            if (state.counter == 3) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Counter is ${state.counter}'),
                    );
                  });
            } else if (state.counter == -1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OtherPage();
              }));
            }
          },
          child: Center(
              child: Text('${context.watch<CounterBloc>().state.counter}',
                  style: TextStyle(fontSize: 52))),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                BlocProvider.of<CounterBloc>(context)
                    .add(IncrementCounterEvent());
              },
              child: Icon(Icons.add),
              heroTag: 'increment',
            ),
            SizedBox(width: 10),
            FloatingActionButton(
              onPressed: () {
                BlocProvider.of<CounterBloc>(context)
                    .add(DecrementCounterEvent());
              },
              child: Icon(Icons.remove),
              heroTag: 'decrement',
            )
          ],
        ));
  }
}
