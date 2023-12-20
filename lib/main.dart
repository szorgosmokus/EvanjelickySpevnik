//import 'dart:ffi';
//Tet comment to see if project is on github

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:wakelock/wakelock.dart';
import 'package:test_app_explore/songbook.dart';

//------- Declaration of values ----------
const String appTitle = "Evanjelický spevník";

const double fontSizeNormal = 20;
const double fontSizeBig = 30;
double fontSizeCurrent = fontSizeNormal;

ThemeData lightTheme =
    ThemeData(brightness: Brightness.light, primarySwatch: Colors.brown);
ThemeData darkTheme =
    ThemeData(brightness: Brightness.dark, primarySwatch: Colors.brown);
ThemeData currentTheme = lightTheme;

String changeTextSize = "Zmeň veľkosť textu";
String changeColorSchceme = "Zmeň farenú schému";
String changeRintone = "Vypnúť zvonenie";

String songDisplayText = '''1.


1. Hospodine, nebeský Otče,
všemohúci náš Bože;
v Tvojej moci všetko je.
Zmiluj sa nad nami!

2. Z Tvojej vôle bol svet
stvorený, a zvlášť človek na
zemi; pre hriech z raja
vyhnaný.
Zmiluj sa nad nami!

3. Ty si ho však predsa
miloval a zahynúť mu nedal,
    Spasiteľa si poslal.
Zmiluj sa nad nami!

4. Kriste, Pane náš, Ty si
pravý Mesiáš, ktorý prišiel na
svet pre nás.

5. Pane najvyšší, ľudské telo
prijal si, tak si sa nám stal
najbližší.

6. Pre to predivné
sväté Tvoje vtelenie,
    zmiluj sa nad nami, Pane!

7. Svätý Duchu, Bože
žiadúci, z Otca, Syna
pochádzajúci, nerozdielny
v božskej moci!

8. Vykonal si božský div
svätý, že bol Kristus v Panne
počatý, aby hriešnym život
vrátil.

9. Ó, nech jeho slávne
vtelenie je nám všetkým na
potešenie.
Zmiluj sa nad nami, Pane!

10. Buď Ti sláva, večný
Bože, Bože jediný,
naveky požehnaný,
a nám pokoj na zemi.
Amen! Staň sa tak, amen!
''';
//I use the 1. song as the initial value to display text in the textbox
//I wasn't able to figure out how to do it more elengantly - eg. getting the text from the assets, so I hardcoded it
//It works.

String songDisplayNumber = "1";

var songNumber =
    TextEditingController(); //I will use this to set the value of the song number in the number selector

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  runApp(const MyApp());
  songNumber.text = songDisplayNumber;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: lightTheme,
      home: const MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  fetchFileData(String songNumber) async {
    String responseText;
    responseText = await rootBundle.loadString('piesne/$songNumber.txt');

    setState(() {
      songDisplayText = responseText;
    });
  }

  changeFontSize() {
    setState(() {
      if (fontSizeCurrent == fontSizeNormal) {
        fontSizeCurrent = fontSizeBig;
      } else {
        fontSizeCurrent = fontSizeNormal;
      }
    });
  }

  changeColorTheme() {
    setState(() {
      if (currentTheme == lightTheme) {
        currentTheme = darkTheme;
      } else {
        currentTheme = lightTheme;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),

          actions: [
            PopupMenuButton(
                onSelected: (value) {
                  if (value == 1) {
                    changeFontSize();
                  }
                  if (value == 2) {
                    changeColorTheme();
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Text(changeTextSize),
                      ),
                      PopupMenuItem(value: 2, child: Text(changeColorSchceme)),
                      PopupMenuItem(value: 3, child: Text(changeRintone)),
                    ])
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: fontSizeCurrent),
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.brown),
                          ),
                        ),
                        controller: songNumber,
                        onChanged: (text) {
                          fetchFileData(text);
                        },
                        onTap: () {
                          // I blank out the input in the textfield when the user taps on it
                          songNumber.text = "";
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      songDisplayText,
                      style: TextStyle(fontSize: fontSizeCurrent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.brown,
              ),
              child: Text(appTitle),
            ),
            ListTile(
              title: const Text('Piesne'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),

            /*
            ListTile(
              title: const Text('Antifóny'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            */
          ],
        )),


        //Floating action button nebudeme pouzivat pri vybere piesni
         /*
        // Tento floating button by sa mozno dal nahradit menej napadnym gombikom v hornom menu.
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSongPickerDialog(context);
          },
          child: const Icon(Icons.list_alt_rounded),
        ), // This trailing comma makes auto-formatting nicer for build methods.
        */
      ),
    );
  }

  // replace this function with the examples above
  showSongPickerDialog(BuildContext context) {
    var dialog = SimpleDialog(
      title: Text('Zvoľte si pieseň'),
      children: _buildDialogOptions(context),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  List<Widget> _buildDialogOptions(BuildContext context) {
    List<Widget> options = [];
    for (final v in piesne) {
      options.add(SimpleDialogOption(
        child: Text(v),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ));
    }
    return options;
  }
}
