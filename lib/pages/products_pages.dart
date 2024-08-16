import 'package:flutter/material.dart';
import 'package:project_name/data/product_data.dart';
import 'package:project_name/models/product_models.dart';
import 'package:project_name/pages/card_page.dart';
import 'package:project_name/pages/favorite_page.dart';
import 'package:project_name/providesr/card_provider.dart';
import 'package:project_name/providesr/fav_provider.dart';
import 'package:provider/provider.dart';

class ProductsPages extends StatelessWidget {
  const ProductsPages({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Shop ',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavouritePage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "Fav_Button",
            child: const Icon(
              color: Colors.white,
              Icons.favorite,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CardPage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: "Shoppin_btn",
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            child: Consumer2<CardProvider, FavProvider>(
              builder: (BuildContext context, CardProvider cartProvider,
                  FavProvider favProvider, Widget? child) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 50),
                      Text(
                        cartProvider.items.containsKey(product.id)
                            ? cartProvider.items[product.id]!.quantity
                                .toString()
                            : "0",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text("\$${product.price.toString()}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          favProvider.toogleFavourites(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                favProvider.isFavourite(product.id)
                                    ? "Added to Fav"
                                    : "Removed from Fav",
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: Icon(
                          favProvider.isFavourite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favProvider.isFavourite(product.id)
                              ? Colors.pinkAccent
                              : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartProvider.addItem(
                              product.id, product.price, product.title);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Added to cart"),
                              duration: Duration(
                                seconds: 2,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: cartProvider.items.containsKey(product.id)
                              ? Colors.deepOrange
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
