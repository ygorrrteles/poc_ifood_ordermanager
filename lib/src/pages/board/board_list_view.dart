import 'package:flutter/material.dart';
import 'package:poc_ifood_ordermanager/src/data/entity/order_entity.dart';
import 'package:poc_ifood_ordermanager/src/data/type.dart';
import 'package:poc_ifood_ordermanager/src/pages/order_detail/order_detail_page.dart';

class BoardListView extends StatelessWidget {
  final List<OrderEntity> orders;
  final ValueChanged<OrderEntity>? onTap;

  const BoardListView({Key? key, required this.orders, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        Widget? action;

        if (order.type == OrderType.onGoing) {
          action = ElevatedButton(
            onPressed: () => onTap?.call(order),
            child: const Text('Aceitar'),
          );
        } else if (order.type == OrderType.delivered) {
          action = ElevatedButton(
            onPressed: () => onTap?.call(order),
            child: const Text('Despachar'),
          );
        }

        return ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OrderDetailPage(order: order),
              ),
            );
          },
          title: Text('#${order.shorId} * ${order.customer}'),
          subtitle: Text(order.merchant),
          trailing: action,
        );
      },
    );
  }
}
