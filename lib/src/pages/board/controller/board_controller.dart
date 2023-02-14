import 'dart:async';
import 'dart:developer';

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
    log('Inicializando a stream do board');
    _subscription = _datasource.stream.listen((order) {
      log('Emitindo estado com a nova lista de pedidos');
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
    log('Realizando a primeira busca no banco de dados');
    final orders = _datasource.getAllMapped();
    emit(BoardLoadedState(orders));
  }

  void acceptOrder(OrderEntity order) {
    log('Aceitando o pedido ${order.shorId}');
    _datasource.put(order.copyWith(type: OrderType.delivered));
  }

  void dispatchOrder(OrderEntity order) {
    log('Despachando o pedido ${order.shorId}');
    _datasource.put(order.copyWith(type: OrderType.concluded));
  }

  void add() {
    _datasource.put(OrderEntity.fromMock());
  }

  void clear() {
    ///TODO: ver isso aqui
    _datasource.clear();
  }
}
