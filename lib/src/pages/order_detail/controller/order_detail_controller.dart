import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:poc_ifood_ordermanager/src/data/datasource/database_impl.dart';
import 'package:poc_ifood_ordermanager/src/data/entity/metadata_driver.dart';
import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';
import 'package:poc_ifood_ordermanager/src/data/type.dart';
import 'package:poc_ifood_ordermanager/src/pages/order_detail/controller/order_detail_state.dart';
import 'package:poc_ifood_ordermanager/src/value_notifier_extension.dart';

class OrderDetailController extends ValueNotifier<OrderDetailState> {
  final OrderEntity _order;
  OrderDetailController(this._order) : super(OrderDetailLoaded(_order));

  final _datasource = DataBaseImpl.instance;
  StreamSubscription? _subscription;

  ///Método chamado no initState do board
  void init() {
    log('Inicializando a stream para a order de id: ${_order.shorId}');
    _subscription = _datasource.streamOf(_order.id).listen((order) {
      log('Emitindo estado com a order atualizada');
      emit(OrderDetailLoaded(order));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }

  void acceptOrder(OrderEntity order) {
    log('Aceitando o pedido ${order.shorId}');
    _datasource.put(order.copyWith(type: OrderType.delivered));
  }

  void dispatchOrder(OrderEntity order) {
    log('Despachando o pedido ${order.shorId}');
    _datasource.put(order.copyWith(type: OrderType.concluded));
  }

  void requestDriver(OrderEntity order) {
    log('Requisitando pessoa entregadora para o pedido ${order.shorId}');
    _datasource.put(order.copyWith(metadataDriver: MetadataDriver.fromMock()));
  }
}
