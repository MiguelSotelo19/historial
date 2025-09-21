import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<int> _historial = [];
  bool _mostrarHistorial = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _historial.add(_counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _historial.add(_counter);
      }
    });
  }

  void _toggleHistory() {
    setState(() {
      _mostrarHistorial = !_mostrarHistorial;
    });
  }

  void _clearHistory() {
    setState(() {
      _historial.clear();
    });
  }

  Widget _buildHistorial() {
    if (_historial.isEmpty) {
      return const Text(
        "No hay historial todavía.",
        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: _historial.length,
        itemBuilder: (context, index) {
          final hist = _historial[index];
          return ListTile(
            leading: const Icon(Icons.check_circle_outline),
            title: Text('Número: $hist'),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            if (_mostrarHistorial) ...[
              const Text(
                "Historial:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildHistorial(),
              ElevatedButton.icon(
                onPressed: _clearHistory,
                icon: const Icon(Icons.delete),
                label: const Text("Limpiar historial"),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _toggleHistory,
            tooltip: 'Mostrar/Ocultar Historial',
            child: const Icon(Icons.history),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.exposure_minus_1),
          ),
        ],
      ),
    );
  }
}
