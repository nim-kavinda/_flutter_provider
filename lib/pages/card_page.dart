import 'package:flutter/material.dart';
import 'package:project_name/models/card_models.dart';
import 'package:project_name/providesr/card_provider.dart';
import 'package:provider/provider.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Card Page ',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Consumer<CardProvider>(
        builder:
            (BuildContext context, CardProvider cartProvider, Widget? child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final CartItem item =
                        cartProvider.items.values.toList()[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 247, 187, 98)
                            .withOpacity(0.5),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(item.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.id),
                            Text("\$${item.price} * ${item.quantity}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cartProvider.removeSingleItem(item.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("One Item Removed"),
                                    duration: Duration(
                                      seconds: 2,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.remove,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cartProvider.removeItem(item.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Removed From Card"),
                                    duration: Duration(
                                      seconds: 2,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.remove_shopping_cart,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Total : \$${cartProvider.totleAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    cartProvider.clearAll();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Cart Clear"),
                        duration: Duration(
                          seconds: 2,
                        ),
                      ),
                    );
                  },
                  child: Text("Clear Card"),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
