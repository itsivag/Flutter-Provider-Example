import 'package:flutter/material.dart';
import 'package:learn/listProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NumberListProvider())
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false, home: FirstPage()));
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<NumberListProvider>(
        builder: (context, numbersProviderModel, child) => Center(
                child: Scaffold(
              appBar: AppBar(
                title: const Text("MyApp"),
                backgroundColor: Colors.black38,
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "Settings"),
                ],
                currentIndex: currIndex,
                onTap: (int index) {
                  setState(() {
                    currIndex = index;
                  });
                },
              ),
              body: currIndex == 0
                  ? Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                          itemCount: numbersProviderModel.numbers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              numbersProviderModel.numbers[index].toString(),
                              style: const TextStyle(fontSize: 20),
                            );
                          },
                        )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const SecondPage();
                              }));
                            },
                            child: const Text("Navigate")),
                      ],
                    )
                  : const Text('Settings'),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    numbersProviderModel.add();
                  },
                  child: const Icon(Icons.add)),
            )));
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NumberListProvider>(
        builder: (context, numbersProviderModel, child) => Scaffold(
              appBar: AppBar(
                title: const Text("MyApp"),
                backgroundColor: Colors.black38,
              ),
              body: Center(
                  child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: numbersProviderModel.numbers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                        numbersProviderModel.numbers[index].toString(),
                        style: const TextStyle(fontSize: 20),
                      );
                    },
                  )),
                ],
              )),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    numbersProviderModel.add();
                  },
                  child: const Icon(Icons.add)),
            ));
  }
}
