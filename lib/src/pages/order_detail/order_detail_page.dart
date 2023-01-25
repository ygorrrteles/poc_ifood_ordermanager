import 'package:flutter/material.dart';
import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';
import 'package:poc_ifood_ordermanager/src/data/type.dart';
import 'package:poc_ifood_ordermanager/src/pages/order_detail/bloc/order_detail_bloc.dart';
import 'package:poc_ifood_ordermanager/src/pages/order_detail/bloc/order_detail_state.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderEntity order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late final _bloc = OrderDetailBloc(widget.order);

  @override
  void initState() {
    super.initState();
    _bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<OrderDetailState>(
      valueListenable: _bloc,
      builder: (context, state, child) {
        Widget? action;

        if (state.order.type == OrderType.onGoing) {
          action = ElevatedButton(
            onPressed: () => _bloc.acceptOrder(state.order),
            child: Text('Aceitar'),
          );
        } else if (state.order.type == OrderType.delivered) {
          action = ElevatedButton(
            onPressed: () => _bloc.dispatchOrder(state.order),
            child: Text('despachar'),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text('Pedido #${state.order.shorId}')),
          bottomNavigationBar: action == null
              ? null
              : SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[300]!))),
                    child: action,
                  ),
                ),
          body: ListView(
            padding: EdgeInsets.all(24),
            children: [
              Text('Status do pedido: ${state.order.type.name}'),
              SizedBox(height: 24),
              Text('Pedido número: ${state.order.shorId}'),
              Text('Cliente: ${state.order.customer}'),
              Text(state.order.merchant),
            ],
          ),
        );
      },
    );
  }
}
