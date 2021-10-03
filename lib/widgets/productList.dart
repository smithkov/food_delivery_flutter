import 'package:flutter/material.dart';
import '../models/item.dart';
import '../screens/itemDetail.dart';

class ProductList extends StatelessWidget {
  final List<Item> products;

  ProductList({Key key, this.products}) : super(key: key);
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: new NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (ct, index) {
            Item data = products[index];

            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ItemDetail(
                              id: data?.id,
                              name: data.name,
                              price: data.price.toString(),
                              photo: data.photo,
                              desc: data.desc,
                              weight: data.weight.toString(),
                              shopId: data.shop.id)));

                      // showModalBottomSheet(
                      //     context: context,
                      //     isScrollControlled: true,
                      //     builder: (context) => SingleChildScrollView(
                      //             child: Container(
                      //           padding: EdgeInsets.only(
                      //               bottom: MediaQuery.of(context)
                      //                   .viewInsets
                      //                   .bottom),
                      //           child: ItemDetail(
                      //               id: data.id,
                      //               name: data.name,
                      //               price: data.price,
                      //               photo: data.photo,
                      //               desc: data.desc,
                      //               weight: data.weight,
                      //               shopId: data.shop.id),
                      //         )));
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image(
                                  image: NetworkImage(data.photo),
                                  height: 90.0,
                                  width: 90.0,
                                  fit: BoxFit.fill),
                            ),
                            SizedBox(width: 50.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  Text("£${data.price}"),
                                  Text('Weight 1kg'),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.red,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.red,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.red,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.red,
                                      ),
                                      Icon(
                                        Icons.star_border,
                                        color: Colors.red,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            );
          }),
    );
  }
}
