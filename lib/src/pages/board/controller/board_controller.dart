import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:poc_ifood_ordermanager/src/data/datasource/database_impl.dart';
import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';
import 'package:poc_ifood_ordermanager/src/data/type.dart';
import 'package:poc_ifood_ordermanager/src/pages/board/controller/board_state.dart';
import 'package:poc_ifood_ordermanager/src/value_notifier_extension.dart';

class BoardController extends ValueNotifier<BoardState> {
  BoardController() : super(BoardLoadedState({}));

  final _datasource = DataBaseImpl.instance;
  StreamSubscription? _subscription;

  void init() {
    _initStream();
    _getOrders();
  }

  void _initStream() {
    _subscription = _datasource.stream.listen((order) {
      value.mappedOrders.update(order.id, (value) => order, ifAbsent: () => order);
      emit(BoardLoadedState(value.mappedOrders));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  void _getOrders() {
    final orders = _datasource.getAllMapped();
    emit(BoardLoadedState(orders));
  }

  void acceptOrder(OrderEntity order) {
    _datasource.put(order.copyWith(type: OrderType.delivered));
  }

  void dispatchOrder(OrderEntity order) {
    _datasource.put(order.copyWith(type: OrderType.concluded));
  }

  void add() {
    _datasource.put(OrderEntity.fromMock());
  }
}
