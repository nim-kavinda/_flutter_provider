import 'package:flutter/material.dart';
import 'package:project_name/data/product_data.dart';
import 'package:project_name/models/product_models.dart';
import 'package:project_name/providesr/fav_provider.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favourite Page ',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Consumer<FavProvider>(
        builder:
            (BuildContext context, FavProvider favProvider, Widget? child) {
          final favItems = favProvider.fav.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList();

          if (favItems.isEmpty) {
            return const Center(
              child: Text("No Fav Added Yet"),
            );
          }
          return ListView.builder(
            itemCount: favItems.length,
            itemBuilder: (context, index) {
              final productId = favItems[index];
              final Product product = ProductData()
                  .products
                  .firstWhere((product) => product.id == productId);

              return Card(
                child: ListTile(
                  title: Text(product.title),
                  subtitle: Text("\$${product.price} "),
                  trailing: IconButton(
                    onPressed: () {
                      favProvider.toogleFavourites(product.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Removed From Favourites"),
                          duration: Duration(
                            seconds: 2,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
