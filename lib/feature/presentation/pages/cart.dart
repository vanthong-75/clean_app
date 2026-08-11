import 'package:clean_app/feature/presentation/utils/add_to_cart.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Cart'),
          Expanded(
            child: ListView.builder(
              itemCount: AddToCart.product_item.length,
              itemBuilder: (context, index) {
                final item = AddToCart.product_item[index];
                int qty = item['Qty'];
                int price = item['price'];
                int total = price * qty;
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            child: Image.network(
                              item['images'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text('${item["name"]}'),
                              SizedBox(height: 5),
                              Text('price : ${item["price"]}'),
                              SizedBox(height: 5),
                              Text('Total : ${total}'),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (item['Qty'] <= 1) {
                                      return;
                                    }
                                    item['Qty'] = item['Qty'] - 1;
                                    total = item['Qty'] * item['price'];
                                  });
                                },
                                icon: Icon(Icons.remove),
                              ),
                              SizedBox(width: 10),
                              Text('${qty}'),
                              SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    item['Qty'] = item['Qty'] + 1;
                                    total = item['Qty'] * item['price'];
                                    print(qty);
                                  });
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                AddToCart.product_item.removeAt(index);
                              });
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
