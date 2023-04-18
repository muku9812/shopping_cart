import 'package:cart/model/cartModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../cartProvider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CardProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          Center(
            child: badges.Badge(
              badgeContent: Consumer<CardProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  );
                },
              ),
              child: const Icon(Icons.shopping_bag_outlined),
            ),
          ),
          const SizedBox(
            width: 20.0,
          )
        ],
      ),
      body: Column(children: [
        FutureBuilder(
            future: cart.getData(),
            builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image(
                                        height: 100,
                                        width: 100,
                                        image: NetworkImage(snapshot
                                            .data![index].image
                                            .toString()),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].productName
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot.data![index].productPrice
                                                      .toString() +
                                                  ' per ' +
                                                  snapshot.data![index].unitTag
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  height: 35,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: const Center(
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
                );
              }
              return const Text(' no data');
            })
      ]),
    );
  }
}
