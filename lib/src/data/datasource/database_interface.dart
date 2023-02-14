import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';

abstract class DataBase {
  Stream<OrderEntity?> get stream;
  Stream<OrderEntity> streamOf(String key);
  Future<void> init();
  OrderEntity? get(String id);
  void put(OrderEntity id);
  List<OrderEntity> getAll();
  Map<String, OrderEntity> getAllMapped();
  void clear();
}
