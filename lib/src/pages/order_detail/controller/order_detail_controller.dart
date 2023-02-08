import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:poc_ifood_ordermanager/src/data/datasource/database_impl.dart';
import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';
import 'package:poc_ifood_ordermanager/src/data/type.dart';
import 'package:poc_ifood_ordermanager/src/pages/order_detail/controller/order_detail_state.dart';
import 'package:poc_ifood_ordermanager/src/value_notifier_extension.dart';

class OrderDetailController extends ValueNotifier<OrderDetailState> {
  final OrderEntity _order;
  OrderDetailController(this._order) : super(OrderDetailLoaded(_order));

  final _datasource = DataBaseImpl.instance;
  StreamSubscription? _subscription;

  void init() {
    _subscription = _datasource.streamOf(_order.id).listen((order) {
      emit(OrderDetailLoaded(order));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  void acceptOrder(OrderEntity order) {
    _datasource.put(order.copyWith(type: OrderType.delivered));
  }

  void dispatchOrder(OrderEntity order) {
    _datasource.put(order.copyWith(type: OrderType.concluded));
  }
}
