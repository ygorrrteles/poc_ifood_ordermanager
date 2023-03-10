import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poc_ifood_ordermanager/src/data/datasource/database_interface.dart';
import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';

class DataBaseImpl implements DataBase {
  DataBaseImpl._();

  static final DataBaseImpl instance = DataBaseImpl._();

  static const BOX_ORDERS = 'BOX_ORDERS';

  late Box<OrderEntity> _box;

  @override
  Stream<OrderEntity> get stream => _box.watch().map<OrderEntity>((event) => event.value);

  @override
  Stream<OrderEntity> streamOf(String key) =>
      _box.watch(key: key).where((event) => event.value != null).map((event) => event.value as OrderEntity);

  @override
  OrderEntity? get(String id) {
    return _box.get(id);
  }

  @override
  List<OrderEntity> getAll() {
    return _box.values.toList();
  }

  @override
  Map<String, OrderEntity> getAllMapped() {
    final map = <String, OrderEntity>{};
    _box.values.forEach((e) => map[e.id] = e);
    return map;
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<OrderEntity>(_OrderEntityTypeAdapter(), override: true);
    _box = await Hive.openBox<OrderEntity>(BOX_ORDERS);
    _box.compact();
  }

  @override
  void put(OrderEntity order) {
    log('Atualizando pedido ${order.shorId}');
    _box.put(order.id, order.copyWith(updateAt: DateTime.now()));
  }

  @override
  void clear() {
    _box.clear();
  }
}

class _OrderEntityTypeAdapter extends TypeAdapter<OrderEntity> {
  @override
  final typeId = 0;

  @override
  OrderEntity read(BinaryReader reader) {
    Map<String, dynamic> map = Map<String, dynamic>.from(reader.readMap());
    map = map.map((key, value) => MapEntry(key, value is Map ? Map<String, dynamic>.from(value) : value));
    return OrderEntity.fromMap(map);
  }

  @override
  void write(BinaryWriter writer, OrderEntity obj) {
    writer.writeMap(obj.toMap);
  }
}
