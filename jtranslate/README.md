
### JSON Setup:
Each supported language is defined in it's own JSON file. The key of each entry is used
to access the value from any given language.
``` json
{
  "key": "value",
  "YouHavePushedTheButtonThisManyTimes" : "You have pushed the button this many times",
  "FlutterDemoPage" : "Flutter Demo Page",
  "FlutterDemo" : "Flutter Demo",
}
```
The translation files must be stored in a subdirectory of `lib`.

The files must also be declared as assets in the `pubspec.yaml` file.

``` yaml
flutter:
  assets:
    - lib/localization/english.translation.json
    - lib/localization/german.translation.json
```

### Generation:

Use the related `jtranslate_generator` package to automatically generate translation-key constants.

https://pub.dev/packages/jtranslate_generator

### Instantiation:
``` dart
translator = JTranslator(
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
```


### Initialization:
For the libary to access the translation json files, it must be initialized. 

This has to happen after the AssetBundle provided by Flutter is built.

#### Option 1:
Initialize asynchronously and reload text-blocks after completion.
``` dart
_translator.init().then((_) {
  setState(() {}); // rebuild with text-blocks
});
```

#### Option 2:
Wait with building the App until initialization is complete.
``` dart
@override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext ctx, AsyncSnapshot<bool> snapshot){
        if(snapshot.hasData){
          return MaterialApp(
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }else{
          return StaticLoadingScreen();
        }
      }, future: translator.init(),
    );
  }
```
