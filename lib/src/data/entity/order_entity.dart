import 'dart:math';

import 'package:poc_ifood_ordermanager/src/data/entity/metadata_driver.dart';
import 'package:poc_ifood_ordermanager/src/data/type.dart';
import 'package:uuid/uuid.dart';

class OrderEntity {
  final String id;
  final String shorId;
  final String merchant;
  final String customer;
  final OrderType type;
  final DateTime createdAt;
  final DateTime updateAt;
  final MetadataDriver? metadataDriver;

  const OrderEntity({
    required this.id,
    required this.shorId,
    required this.merchant,
    required this.customer,
    required this.type,
    required this.createdAt,
    required this.updateAt,
    this.metadataDriver,
  });

  Map<String, dynamic> get toMap => {
        'id': id,
        'shorId': shorId,
        'merchant': merchant,
        'customer': customer,
        'type': type.name,
        'createdAt': createdAt.toIso8601String(),
        'updateAt': updateAt.toIso8601String(),
        'metadataDriver': metadataDriver?.toMap,
      };

  factory OrderEntity.fromMock() {
    final id = const Uuid().v4();
    final customerId = Random().nextInt(100);
    final shortId = Random().nextInt(9999).toString().padLeft(4, '0');
    final createdAt = DateTime.now();
    final updateAt = DateTime.now();
    return OrderEntity(
      id: id,
      shorId: shortId,
      customer: customerNames[customerId],
      merchant: 'Restaurante do iFood',
      type: OrderType.onGoing,
      createdAt: createdAt,
      updateAt: updateAt,
    );
  }

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    return OrderEntity(
      id: map['id'] as String,
      shorId: map['shorId'] as String,
      merchant: map['merchant'] as String,
      customer: map['customer'] as String,
      type: OrderType.values.firstWhere((element) => element.name == map['type']),
      createdAt: DateTime.parse(map['createdAt']),
      updateAt: DateTime.parse(map['updateAt']),
    );
  }

  OrderEntity copyWith({
    String? id,
    String? shorId,
    String? merchant,
    String? customer,
    OrderType? type,
    DateTime? createdAt,
    DateTime? updateAt,
    MetadataDriver? metadataDriver,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      shorId: shorId ?? this.shorId,
      merchant: merchant ?? this.merchant,
      customer: customer ?? this.customer,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
      metadataDriver: metadataDriver ?? this.metadataDriver,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is OrderEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const customerNames = [
  "Miguel",
  "Davi",
  "Arthur",
  "Pedro",
  "Gabriel",
  "Bernardo",
  "Lucas",
  "Matheus",
  "Rafael",
  "Heitor",
  "Enzo",
  "Guilherme",
  "Nicolas",
  "Lorenzo",
  "Gustavo",
  "Felipe",
  "Samuel",
  "Jo??o",
  "Daniel",
  "Vitor",
  "Leonardo",
  "Henrique",
  "Theo",
  "Murilo",
  "Eduardo",
  "Pedro",
  "Pietro",
  "Cau??",
  "Isaac",
  "Caio",
  "Vinicius",
  "Benjamin",
  "Jo??o",
  "Lucca",
  "Jo??o",
  "Bryan",
  "Joaquim",
  "Jo??o",
  "Thiago",
  "Ant??nio",
  "Davi",
  "Francisco",
  "Enzo",
  "Bruno",
  "Emanuel",
  "Jo??o",
  "Ian",
  "Davi",
  "Rodrigo",
  "Ot??vio",
  "Sophia",
  "Alice",
  "Julia",
  "Isabella",
  "Manuela",
  "Laura",
  "Luiza",
  "Valentina",
  "Giovanna",
  "Eduarda",
  "Helena",
  "Beatriz",
  "Luiza",
  "Lara",
  "Mariana",
  "Nicole",
  "Rafaela",
  "Helo??sa",
  "Isadora",
  "L??via",
  "Clara",
  "Clara",
  "Lorena",
  "Gabriela",
  "Yasmin",
  "Isabelly",
  "Sarah",
  "Julia",
  "Let??cia",
  "Luiza",
  "Melissa",
  "Marina",
  "Clara",
  "Cec??lia",
  "Esther",
  "Emanuelly",
  "Rebeca",
  "Beatriz",
  "Lav??nia",
  "Vit??ria",
  "Bianca",
  "Catarina",
  "Larissa",
  "Fernanda",
  "Fernanda",
  "Amanda",
  "Al??cia",
  "Carolina",
  "Agatha",
  "Gabrielly"
];
