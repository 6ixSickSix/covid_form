import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FormPage(),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1(
      {super.key,
      required this.firstname,
      required this.lastname,
      required this.gender,
      required this.option,
      required this.age});

  final String firstname;
  final String lastname;
  final String gender;
  final List<String> option;
  final int age;
  final String description = 'Hello World';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network('https://www.healthwatchsheffield.co.uk/sites/healthwatchsheffield.co.uk/files/styles/grid_image_33/public/p941-hwe-covid-19-icon-2-all.png?itok=0V27TJX8',
            width: 300, height: 300,fit: BoxFit.cover,),
            covidDetect(option)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Page2(
                      description: description,
                    )),
          )
        },
        child: const Text('ยืนยัน'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget covidDetect(List<String> option) {
    String  genderType = checkGender(gender);
    if (option.length >= 3) {
      return Container(
        width: 300,
        height: 300,
        child: Center(child: Text('คุณ$genderType $firstname  $lastname, อายุ $age คุณเป็นโควิท')),
      );
    } else {
      return Container(
        width: 300,
        height: 300,
        child: Center(child: Text('คุณ$genderType $firstname  $lastname, อายุ $age คุณเป็นไม่โควิท')),
      );
    }
  }

  String checkGender(String gender)
  {
    return gender == 'Male' ? 'ชาย' : 'หญิง';
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Text(
              description,
              style: const TextStyle(color: Colors.green),
            )),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ThirdPage()))
              },
              child: const Text('Back'),
            )
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Third Page'),
      ),
      body: Container(
        child: const Text('Page1'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.pop(
            context,
          )
        },
        child: const Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  late String firstname;
  late String lastname;
  late int age;
  late String selectedGender = '';

  void _onRadioButtonChanged(String value) {
    setState(() {
      selectedGender = value;
    });
  }

  late bool _isOption1 = false;
  late bool _isOption2 = false;
  late bool _isOption3 = false;
  String option1 = 'ไอ';
  String option2 = 'เจ็บคอ';
  String option3 = 'มีไข้';
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('FirstName'),
                TextFormField(
                  initialValue: 'Hello',
                  onSaved: (value) => setState(() {
                    firstname = value!;
                  }),
                ),
                const Text('Lastname'),
                TextFormField(
                  initialValue: 'Wick',
                  onSaved: (value) => setState(() {
                    lastname = value!;
                  }),
                ),
                 const Text('Age'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (value) => setState(() {
                    age = int.parse(value!);
                  }),
                ),
                const Text('Gender'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Male'),
                    Radio(
                        value: 'Male',
                        groupValue: selectedGender,
                        onChanged: (value) => _onRadioButtonChanged(value!)),
                    const Text('Female'),
                    Radio(
                        value: 'Female',
                        groupValue: selectedGender,
                        onChanged: (value) => _onRadioButtonChanged(value!)),
                  ],
                ),
                const Text('Symtomps'),
                Column(
                  children: [
                    CheckboxListTile(
                        title: Text(option1),
                        value: _isOption1,
                        onChanged: (value) => setState(() {
                              _isOption1 = !_isOption1;
                              if (_isOption1) {
                                selectedOptions.add(option1);
                              } else {
                                selectedOptions.remove(option1);
                              }
                            })),
                    CheckboxListTile(
                        title: Text(option2),
                        value: _isOption2,
                        onChanged: (value) => setState(() {
                              _isOption2 = !_isOption2;
                              if (_isOption2) {
                                selectedOptions.add(option2);
                              } else {
                                selectedOptions.remove(option2);
                              }
                            })),
                    CheckboxListTile(
                        title: Text(option3),
                        value: _isOption3,
                        onChanged: (value) => setState(() {
                              _isOption3 = !_isOption3;
                              if (_isOption3) {
                                selectedOptions.add(option3);
                              } else {
                                selectedOptions.remove(option3);
                              }
                            })),
                  ],
                ),
                ElevatedButton(
                    onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {
                              _formKey.currentState?.save(),
                              print(firstname),
                              print(lastname),
                              print(selectedGender),
                              print(selectedOptions),
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Page1(
                                            firstname: firstname,
                                            lastname: lastname,
                                            gender: selectedGender,
                                            option: selectedOptions,
                                            age : age,
                                          )))
                            }
                        },
                    child: const Text('Save')),
              ],
            )),
      ),
    );
  }
}
