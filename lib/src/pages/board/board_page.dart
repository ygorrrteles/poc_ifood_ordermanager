import 'package:flutter/material.dart';
import 'package:poc_ifood_ordermanager/src/data/type.dart';
import 'package:poc_ifood_ordermanager/src/pages/board/bloc/board_bloc.dart';
import 'package:poc_ifood_ordermanager/src/pages/board/bloc/board_state.dart';
import 'package:poc_ifood_ordermanager/src/pages/board/board_list_view.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  final _bloc = BoardBloc();
  OrderType type = OrderType.onGoing;

  void _onTapNavBar(int index) {
    if (type.index == index) return;
    setState(() => type = OrderType.values[index]);
  }

  @override
  void initState() {
    super.initState();
    _bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    final fab = FloatingActionButton(
      onPressed: _bloc.add,
      child: const Icon(Icons.add),
    );

    return ValueListenableBuilder<BoardState>(
      valueListenable: _bloc,
      builder: (context, state, child) {
        Widget child;

        if (type == OrderType.onGoing) {
          child = BoardListView(
            onTap: _bloc.acceptOrder,
            orders: state.onGoing,
          );
        } else if (type == OrderType.delivered) {
          child = BoardListView(
            onTap: _bloc.dispatchOrder,
            orders: state.delivered,
          );
        } else if (type == OrderType.concluded) {
          child = BoardListView(orders: state.concluded);
        } else {
          child = const SizedBox.shrink();
        }

        return Scaffold(
          appBar: AppBar(title: Text('Gestor de Pedidos * total: ${state.mappedOrders.values.length}')),
          floatingActionButton: fab,
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onTapNavBar,
            currentIndex: type.index,
            items: [
              BottomNavigationBarItem(
                icon: Text('${state.onGoing.length}'),
                label: 'Novos',
              ),
              BottomNavigationBarItem(
                icon: Text('${state.delivered.length}'),
                label: 'Entrega',
              ),
              BottomNavigationBarItem(
                icon: Text('${state.concluded.length}'),
                label: 'Concluídos',
              ),
            ],
          ),
          body: child,
        );
      },
    );
  }
}
