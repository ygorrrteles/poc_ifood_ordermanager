import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';
import 'package:poc_ifood_ordermanager/src/data/type.dart';

abstract class BoardState {
  final Map<String, OrderEntity> mappedOrders;
  final List<OrderEntity> onGoing = [];
  final List<OrderEntity> delivered = [];
  final List<OrderEntity> concluded = [];

  BoardState(this.mappedOrders) {
    final orders = mappedOrders.values.toList()..sort((a, b) => b.updateAt.compareTo(a.updateAt));
    for (final order in orders) {
      switch (order.type) {
        case OrderType.onGoing:
          onGoing.add(order);
          break;
        case OrderType.delivered:
          delivered.add(order);
          break;
        case OrderType.concluded:
          concluded.add(order);
          break;
      }
    }
  }
}

class BoardLoadedState extends BoardState {
  BoardLoadedState(super.mappedOrders);
}
