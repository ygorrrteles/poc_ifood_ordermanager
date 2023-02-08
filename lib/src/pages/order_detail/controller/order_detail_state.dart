import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';

abstract class OrderDetailState {
  final OrderEntity order;
  const OrderDetailState(this.order);
}

class OrderDetailLoaded extends OrderDetailState {
  const OrderDetailLoaded(super.order);
}
