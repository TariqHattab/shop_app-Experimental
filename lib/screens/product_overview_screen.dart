import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './cart_screen.dart';
import '../widgets/main_drawer.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { All, Favorites }

class ProductOverviewScreen extends StatefulWidget {
//static const routeName = '/product_overview_screen';

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _onlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Product Overview'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show All'),
              ),
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Favorite'),
              )
            ],
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.All) {
                  _onlyFavorites = false;
                } else {
                  _onlyFavorites = true;
                }
              });
            },
          ),
          Consumer<Cart>(
              builder: (_, cart, ch) =>
                  Badge(child: ch, value: cart.itemsCount.toString()),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ))
        ],
      ),
      body: ProductsGrid(onlyFavorites: _onlyFavorites),
    );
  }
}
