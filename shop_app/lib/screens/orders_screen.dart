import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapshot.error != null) {
            return const Center(
              child: Text(
                'An error occured!',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          return Consumer<Orders>(
            builder: (ctx, orderData, child) => orderData.orders.isEmpty
                ? child!
                : ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (_, i) => OrderItem(orderData.orders[i]),
                  ),
            child: const Center(
              child: Text(
                'No orders found',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
