import '../models/productCart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/providerData.dart';
import '../screens/itemDetail.dart';

class OrderList extends StatelessWidget {
  final shopId;
  OrderList({this.shopId});
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(
      builder: (context, productCart, child) {
        List<ProductCart> products = productCart.productList(shopId);

        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String itemPrice =
                    (products[index].quantity * products[index].price)
                        .toStringAsFixed(2);

                return GestureDetector(
                  onTap: () {
                    ProductCart product = Provider.of<ProviderData>(context)
                        .getProductById(products[index].id, shopId);

                    if (product != null) {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Column(
                                children: [
                                  Expanded(
                                    // padding: EdgeInsets.only(
                                    //     bottom: MediaQuery.of(context)
                                    //         .viewInsets
                                    //         .bottom),
                                    child: ItemDetail(
                                        id: product.id,
                                        name: product.name,
                                        price: product.price.toString(),
                                        photo: product.photo,
                                        desc: product.desc,
                                        weight: product.weight,
                                        shopId: product.shopId),
                                  ),
                                ],
                              ));
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircleAvatar(
                            child: Text(
                              '${products[index].quantity}',
                              style: TextStyle(color: Colors.black54),
                            ),
                            backgroundColor: Colors.lightBlueAccent,
                            radius: 15.0,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                              child: Text('${products[index].name} ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.0),
                                  overflow: TextOverflow.ellipsis)),
                          SizedBox(
                            width: 100.0,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: Text(
                                '£${itemPrice}',
                                style: TextStyle(
                                    fontSize: 19.0, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: products.length,
            ),
          ],
        );
      },
    );
  }
}
