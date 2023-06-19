import 'package:objectbox/objectbox.dart';

@Entity()
class ServiceTime {
  int id;
  double time;
  String name;

  ServiceTime({
    this.id = 0,
    required this.time,
    required this.name,
  });
}
