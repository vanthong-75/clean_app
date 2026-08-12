import 'package:clean_app/feature/presentation/components/button_component.dart';
import 'package:clean_app/feature/presentation/utils/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String images;
  final int price;
  const ProductDetail({super.key, required this.name, required this.images, required this.price,});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  int Qty = 1;
  int Total = 0;
  final NumberFormat formatter = NumberFormat();

  @override

  void initState () {
    super.initState();
    Total = Qty * widget.price;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Details'),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: Image.network(widget.images,fit: BoxFit.fill,),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.name}'),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Text('ນະຄອນຫຼວງວຽງຈັນ,ໄຊທານີ,ດົງໂດກ'),
                            ],
                          )

                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(onPressed: () {
                          setState(() {
                            if (Qty <= 1) {
                              return;
                            }
                            Qty = Qty - 1;
                            Total = Qty * widget.price;
                          });
                        }, 
                        child: Icon(Icons.remove)),
                        SizedBox(width: 10,),
                        Text('${Qty}'),
                        SizedBox(width: 10,),
                        ElevatedButton(onPressed: () {
                          setState(() {
                            Qty = Qty + 1;
                            Total = Qty * widget.price;
                          });
                        }, 
                        child: Icon(Icons.add)),
                      ],
                    )
                  ],
                ),
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(' Price : ${formatter.format(widget.price)} ₭ '),
                          Text('Total : ${formatter.format(Total)} ₭ ')
                        ],
                      ),
                     SizedBox(
                      width: 200,
                      child: ButtonComponent.buttonComponent(context, 'Add to cart', Icon(Icons.shopping_cart), (){
                        bool exist = false;
                        for (var p in AddToCart.product_item){
                          if(p["name"] == widget.name){
                            p["Qty"] = p["Qty"] + Qty;
                            exist = true;
                            break;
                          }
                        }
                        if(exist == false){
                          AddToCart.product_item.add({
                          "name": widget.name, "images": widget.images, "Qty": Qty, "price": widget.price,
                        });
                        }
                        print(AddToCart.product_item);
                      })) 
                    ],

                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}