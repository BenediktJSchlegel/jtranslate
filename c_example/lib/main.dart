import 'package:flutter/material.dart';
import 'package:jtranslate/jtranslate.dart';
import 'package:jtranslate_example/enums/language_keys.dart';

import 'localization/english.translation.g.dart';

void main() async {
  _MyHomePageState._translator = JTranslator(
    JTranslatorConfiguration(
        sets: [
          LanguageSet(LanguageKeys.english.name,
              "lib/localization/english.translation.json"),
          LanguageSet(LanguageKeys.german.name,
              "lib/localization/german.translation.json")
        ],
        fallbackKey: LanguageKeys.english.name,
        initialKey: LanguageKeys.english.name,
        outOfSetToken: "<NO TEXT>",
        preCacheAllLanguages: false),
  );

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
        useMaterial3: true,
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
  static late JTranslator _translator;

  int _counter = 0;

  @override
  void initState() {
    super.initState();

    _translator.init().then((value) {
      setState(() {});
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
            Text(
              _translator[TranslationKeys.youHavePushedTheButtonThisManyTimes],
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(_translator[TranslationKeys
                .onlyInEnglish]), // This Text falls back to english, since it does not exist in german
            Text(_translator.get(
                "nonExistentTranslationKey")), // This Text falls back to the outOfSetToken, since it does not exist
            ElevatedButton(
                onPressed: () => _onButtonClicked(LanguageKeys.english),
                child: const Text("English")),
            ElevatedButton(
                onPressed: () => _onButtonClicked(LanguageKeys.german),
                child: const Text("German")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onButtonClicked(LanguageKeys key) {
    setState(() {
      _translator.set(key.name);
    });
  }
}
