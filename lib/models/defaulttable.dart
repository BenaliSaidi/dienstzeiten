import 'package:dienstzeiten/models/service_time.dart';
import 'package:dienstzeiten/objectbox.g.dart';

setDefaultServiceTime(Store store) {
  Map<String, double> F_time = {
    "F0": 3.75,
    "F1": 6.25,
    "F2": 7.25,
    "F3": 6.75,
    "F4": 4.75,
    "F5": 9,
    "F6": 5,
    "F7": 5.75,
    "F8": 8,
    "F9": 8,
    "F10": 7.25,
    "F11": 5.25,
    "F12": 4.5,
    "F13": 5.5,
    "F14": 5.5,
    "F15": 5.75,
    "F16": 8,
  };

  Map<String, double> S_time = {
    "S0": 8.0,
    "S1": 8.75,
    "S2": 8.0,
    "S3": 7.0,
    "S4": 6.5,
    "S5": 6,
    "S6": 5.5,
    "S7": 4.0,
    "S8": 4.75,
    "S9": 4.5,
    "S10": 8.0,
  };
  Map<String, double> N_time = {
    "N1": 7.5,
    "N2": 9.0,
    "N3": 8.75,
  };
  Map<String, double> GT_time = {
    "GT": 8.75,
    "GT1": 9.25,
    "GT2": 8.75,
  };
  Map<String, double> M_time = {
    "M0": 2.5,
    "M1": 4.0,
    "M2": 4.0,
    "M3": 2.0,
    "M4": 4.75,
  };
  Map<String, double> T_time = {
    "T0": 7.5,
    "T1": 8.0,
    "T2": 7.0,
  };

  final timeBox = store.box<ServiceTime>();

  F_time.forEach((key, value) {
    final myTime = ServiceTime(name: key, time: value,);
    timeBox.put(myTime);
  });

  N_time.forEach((key, value) {
    final myTime = ServiceTime(name: key, time: value,);
    timeBox.put(myTime);
  });

  GT_time.forEach((key, value) {
    final myTime = ServiceTime(name: key, time: value,);
    timeBox.put(myTime);
  });

  M_time.forEach((key, value) {
    final myTime = ServiceTime(name: key, time: value,);
    timeBox.put(myTime);
  });

  S_time.forEach((key, value) {
    final myTime = ServiceTime(name: key, time: value, );
    timeBox.put(myTime);
  });
  T_time.forEach((key, value) {
    final myTime = ServiceTime(name: key, time: value);
    timeBox.put(myTime);
  });
}
