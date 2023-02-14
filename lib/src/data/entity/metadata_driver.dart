import 'dart:math';

import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';

class MetadataDriver {
  final String name;
  final DateTime updatedAt;

  String get updatedAtFormatted => "${updatedAt.hour}:${updatedAt.minute}:${updatedAt.second}";

  const MetadataDriver({required this.name, required this.updatedAt});

  Map<String, dynamic> get toMap => {
        'name': name,
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory MetadataDriver.fromMap(Map<String, dynamic> map) {
    return MetadataDriver(
      name: map['name'] as String,
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  factory MetadataDriver.fromMock() {
    final randomId = Random().nextInt(100);

    return MetadataDriver(
      name: customerNames[randomId],
      updatedAt: DateTime.now(),
    );
  }
}
