import 'package:cart/cartProvider.dart';
import 'package:cart/dbHelper.dart';
import 'package:cart/model/cartModel.dart';
import 'package:cart/screens/cartScreen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<String> productName = [
    'Apple',
    'Mango',
    'Orange',
    'Dragon fruit',
    'Grapes',
    'Banana',
    'Cherry',
    'Mixed Fruits'
  ];
  List<String> ProductUnit = [
    'Kg',
    'Kg',
    'Kg',
    'Kg',
    'Kg',
    'Dozen',
    'Dozen',
    'Kg'
  ];
  List<int> productPrice = [200, 250, 100, 600, 280, 120, 140, 420];
  List<String> productImage = [
    'https://w7.pngwing.com/pngs/999/693/png-transparent-red-apples-on-basket-apple-crisp-fruit-gift-basket-apple-basket-natural-foods-food-superfood-thumbnail.png',
    'https://freesvg.org/img/mango_fruit.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkNs-Hs7w2puH6KF3rjUwtueLbWILF8u6R-jQ1Krhveg&s',
    'https://img.freepik.com/free-vector/vector-whole-sliced-vivid-pink-dragon-fruit-isolated-white-background_1284-45468.jpg?w=2000',
    'https://thumbs.dreamstime.com/b/bunch-white-grapes-38390416.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPxgKzZ2kMEMMSOIa6Az_WWKD9Jb-_XKokiw&usqp=CAU',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/TheStructorr_cherries.svg/256px-TheStructorr_cherries.svg.png?20110715235116',
    'https://image.pngaaa.com/779/492779-middle.png'
  ];
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CardProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Center(
              child: badges.Badge(
                badgeContent: Consumer<CardProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    );
                  },
                ),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: productName.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image(
                                  height: 100,
                                  width: 100,
                                  image: NetworkImage(
                                      productImage[index].toString()),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productName[index].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        productPrice[index].toString() +
                                            ' per ' +
                                            ProductUnit[index].toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            dbHelper!
                                                .insert(
                                              Cart(
                                                  id: index,
                                                  productId: index.toString(),
                                                  productName:
                                                      productName[index]
                                                          .toString(),
                                                  initialPrice:
                                                      productPrice[index],
                                                  productPrice:
                                                      productPrice[index],
                                                  quantity: 1,
                                                  unitTag: ProductUnit[index]
                                                      .toString(),
                                                  image: productImage[index]
                                                      .toString()),
                                            )
                                                .then((value) {
                                              cart.addTotalPrice(double.parse(
                                                  productPrice[index]
                                                      .toString()));
                                              cart.addCounter();
                                              print(
                                                  'Product added successfully');
                                            }).onError((error, stackTrace) {
                                              print(error.toString());
                                            });
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                                child: Text(
                                              'Add to Cart',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
