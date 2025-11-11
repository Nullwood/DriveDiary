import 'package:flutter/material.dart';
import 'form_screen.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _increment10() {
    setState(() {
      _counter += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DriveDiary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ваш пробег: '),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            child: const Icon(Icons.add_box),
            backgroundColor: Colors.grey,
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _increment10,
            child: const Icon(Icons.add),
            backgroundColor: Colors.grey,
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormScreen()),
              );
            },
            child: const Icon(Icons.add_call),
            backgroundColor: Colors.grey,
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailsScreen()),
              );
            },
            child: const Icon(Icons.add_alarm),
            backgroundColor: Colors.grey,
          )
        ],
      ),
    );
  }
}