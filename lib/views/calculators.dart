import 'package:dienstzeiten/models/defaulttable.dart';
import 'package:dienstzeiten/models/service_time.dart';
import 'package:dienstzeiten/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

var _store;

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store =
        await openStore(directory: p.join(docsDir.path, "obx-example"));
    _store = store;
    return ObjectBox._create(store);
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

final _formKey = GlobalKey<FormState>();

class _CalculatorState extends State<Calculator> {
  @override
  initState() {
    setNewOrder();
  }

  List<String> serviceNameList = <String>["F", "S", "N", "GT", "T", "M"];

  var numList = List<int>.generate(100, (i) => i + 1);
  List<ServiceTime> newOrdre = [];

  double? mytime;

  String? myserviceName;
  String? myserviceTime;
  List<double> reelSummeListe = [];
  List<String> letSummeListe = [];
  List<double> timeSummeListe = [];
  double? sumToDisplay;
  String letToDisplay = "";
  String timeToDisplay = "";

  @override
  checktable() {
    if (_store.box<ServiceTime>().isEmpty()) {
      setDefaultServiceTime(_store);
    }
  }

  addNewTime(String name, double time) {
    final timeBox = _store.box<ServiceTime>();
    final serviceTime = ServiceTime(name: name, time: time);
    timeBox.put(serviceTime);
  }

  reelSumme(List myList) {
    double sum = myList.fold(0, (a, b) => a + b);
    sumToDisplay = sum;
    print(sum);
  }

  letSumme(List myletList, List myTimeListe) {
    letToDisplay = myletList.join(" - ");
    timeToDisplay = myTimeListe.join(" - ");
  }

  setNewOrder() {
    newOrdre.clear();
    final timeBox = _store.box<ServiceTime>();

    final query_F = (timeBox.query(ServiceTime_.name.startsWith('F'))).build();
    final results_F = query_F.find();
    query_F.close();

    for (var i = 0; i < results_F.length; i++) {
      newOrdre.add(results_F[i]);
    }
    final query_S = (timeBox.query(ServiceTime_.name.startsWith('S'))).build();
    final results_S = query_S.find();
    query_S.close();

    for (var i = 0; i < results_S.length; i++) {
      newOrdre.add(results_S[i]);
    }

    final query_N = (timeBox.query(ServiceTime_.name.startsWith('N'))).build();
    final results_N = query_N.find();
    query_N.close();

    for (var i = 0; i < results_N.length; i++) {
      newOrdre.add(results_N[i]);
    }

    final query_M = (timeBox.query(ServiceTime_.name.startsWith('M'))).build();
    final results_M = query_M.find();
    query_M.close();

    for (var i = 0; i < results_M.length; i++) {
      newOrdre.add(results_M[i]);
    }

    final query_GT =
        (timeBox.query(ServiceTime_.name.startsWith('GT'))).build();
    final results_GT = query_GT.find();
    query_GT.close();

    for (var i = 0; i < results_GT.length; i++) {
      newOrdre.add(results_GT[i]);
    }

    final query_T = (timeBox.query(ServiceTime_.name.startsWith('T'))).build();
    final results_T = query_T.find();
    query_T.close();

    for (var i = 0; i < results_T.length; i++) {
      newOrdre.add(results_T[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    String myname = serviceNameList.first;
    print(newOrdre.length);
    int mynum = numList.first;
    checktable();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rechner"),
        centerTitle: true,
        backgroundColor: Color(0xff292D36),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 80,
            width: double.infinity,
            color: Color(0xff22252D),
            child: Text(letToDisplay,
                style: TextStyle(
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 90,
            width: double.infinity,
            color: Color(0xff22252D),
            child: Text(timeToDisplay,
                style: TextStyle(
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 80,
            width: double.infinity,
            color: Color(0xff22252D),
            child: sumToDisplay == null
                ? const Text("0",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      color: Color.fromARGB(255, 224, 224, 224),
                    ))
                : Text(sumToDisplay.toString(),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      color: Color.fromARGB(255, 224, 224, 224),
                    )),
          ),
          Container(
            color: Color(0xff292D36),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        backgroundColor: Color(0xff22252D)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                backgroundColor: Color(0xff22252D),
                                content: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Container(
                                    height: 220,
                                    padding: EdgeInsets.all(10),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                              // height: 10,
                                              ),
                                          const Text(
                                            'fügen Sie Ihre neue Dienstzeit ein',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white70),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 80,
                                                        child: DropdownButton(
                                                          focusColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  46,
                                                                  51,
                                                                  61),
                                                          dropdownColor:
                                                              Color(0xff22252D),
                                                          elevation: 16,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white70),
                                                          underline: Container(
                                                            height: 2,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                          value: myname,
                                                          isExpanded: true,
                                                          items: serviceNameList.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child: Text(
                                                                  "   $value"),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) =>
                                                              setState(() {
                                                            myname = value!
                                                                .toString();
                                                          }),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 80,
                                                        child: DropdownButton(
                                                          focusColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  46,
                                                                  51,
                                                                  61),
                                                          dropdownColor:
                                                              Color(0xff22252D),
                                                          elevation: 16,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white70),
                                                          underline: Container(
                                                            height: 2,
                                                            color:
                                                                Colors.white70,
                                                          ),
                                                          value: mynum,
                                                          isExpanded: true,
                                                          items: numList.map<
                                                              DropdownMenuItem<
                                                                  int>>((int
                                                              value) {
                                                            return DropdownMenuItem<
                                                                int>(
                                                              value: value,
                                                              child: Text(
                                                                  "   $value "),
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) =>
                                                              setState(() {
                                                            mynum = value!;
                                                          }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white70,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 2,
                                                            color:
                                                                Colors.white70),
                                                      ),
                                                      isDense: true,
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xff22252D),
                                                      labelText: 'Zeit',
                                                      labelStyle: TextStyle(
                                                          color: Colors.white70,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 2,
                                                            color:
                                                                Colors.white70),
                                                      ),
                                                    ),
                                                    onSaved: (value) {
                                                      mytime =
                                                          double.parse(value!);
                                                    },
                                                    validator: (value) {
                                                      // if (value!.isEmpty) {
                                                      //   // Toast.show(
                                                      //   //     "please add a valid definition",
                                                      //   //     duration: Toast
                                                      //   //         .lengthShort,
                                                      //   //     gravity:
                                                      //   //         Toast.bottom);
                                                      // }
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  // ignore: prefer_const_constructors
                                                  SizedBox(
                                                      width: double.infinity,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                            Color.fromARGB(255,
                                                                17, 19, 23),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            _formKey
                                                                .currentState!
                                                                .save();
                                                            var finalTime =
                                                                (myname +
                                                                    mynum
                                                                        .toString());

                                                            addNewTime(
                                                                finalTime,
                                                                mytime!);
                                                            _formKey
                                                                .currentState!
                                                                .reset();
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                          setState(() =>
                                                              setNewOrder());
                                                        },
                                                        child: const Text(
                                                          'Schpeichern',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Comfortaa',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ))
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                          });
                    },
                    child: Text("hinzufügen",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green[500],
                        ))),
                OutlinedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        backgroundColor: Color(0xff22252D)),
                    onPressed: () {
                      setState(() {
                        reelSummeListe.clear();
                        letSummeListe.clear();
                        timeSummeListe.clear();
                        reelSumme(reelSummeListe);
                        letSumme(letSummeListe, timeSummeListe);
                      });
                    },
                    child: Text(
                      "alle löschen",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red[400],
                      ),
                    )),
                OutlinedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        backgroundColor: Color(0xff22252D)),
                    onPressed: () {
                      setState(() {
                        if (reelSummeListe.isNotEmpty) {
                          reelSummeListe.removeLast();
                          letSummeListe.removeLast();
                          timeSummeListe.removeLast();
                          reelSumme(reelSummeListe);
                          letSumme(letSummeListe, timeSummeListe);
                        }
                      });
                    },
                    child: Text("löschen"))
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Color(0xff292D36),
              child: GridView.count(
                crossAxisCount: 5,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                children: List.generate(newOrdre.length, (index) {
                  return OutlinedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          backgroundColor: Color(0xff22252D)),
                      onPressed: () {
                        setState(() {
                          reelSummeListe.add(newOrdre[index].time);
                          letSummeListe.add(newOrdre[index].name);
                          timeSummeListe.add(newOrdre[index].time);
                          reelSumme(reelSummeListe);
                          letSumme(letSummeListe, timeSummeListe);
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          final timeBox = _store.box<ServiceTime>();
                          timeBox.remove(newOrdre[index].id);
                          newOrdre.remove(newOrdre[index]);
                        });
                      },
                      child: Text(newOrdre[index].name));
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
