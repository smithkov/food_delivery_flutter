import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/providerData.dart';
import '../screens/checkout_page.dart';
//import 'package:food_app_flutter_zone/src/pages/food_details_page.dart';

import '../widgets/orderList.dart';
import '../widgets/allergyBox.dart';
import '../utility/conversions.dart';
//import '../widgets/home_top_info.dart';
//import '../widgets/food_category.dart';
//import '../widgets/search_file.dart';

// Model
import '../models/shop.dart';

class OrderListPage extends StatefulWidget {
  final Shop shop;

  OrderListPage({this.shop});

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    var shop = widget.shop;
    var deliverPrice = shop.deliveryPrice;
    var minimumOrder = shop.minOrder;
    var diskountAmount = shop.discountAmount;
    var percentDiscount = shop.percentageDiscount;

    if (deliverPrice == null) {
      deliverPrice = "0";
    }
    if (minimumOrder == null) {
      minimumOrder = "0";
    }

    if (diskountAmount == null) {
      diskountAmount = "0";
    }
    if (percentDiscount == null) {
      percentDiscount = "0";
    }
    double deliveryPrice =
        Provider.of<ProviderData>(context).getDeliveryPrice();
    double subTotal = double.parse(
        Provider.of<ProviderData>(context).getTotalShopAmount(widget.shop.id));
    //double deliveryPrice = double.parse(deliverPrice);

    double minOrder = double.parse(minimumOrder);
    bool canDeliver =
        Provider.of<ProviderData>(context).canDeliver(widget.shop.id, minOrder);

    double remainderAmount = Provider.of<ProviderData>(context)
        .getRemainderAmount(minOrder, widget.shop.id);

    double discountAmount = double.parse(diskountAmount);
    //var discountPercent = double.parse(widget.shop.percentageDiscount);

    var discountPercent = double.parse(percentDiscount);
    bool canShowOffer = Provider.of<ProviderData>(context)
        .canShowOffer(discountPercent, discountAmount, widget.shop.id);
    double total = Provider.of<ProviderData>(context).grandTotal(
        discountPercent, discountAmount, deliveryPrice, widget.shop.id);
    double discount = Provider.of<ProviderData>(context).discount(
        discountPercent, discountAmount, deliveryPrice, widget.shop.id);

    bool canDiscountInRow = Provider.of<ProviderData>(context)
        .canDiscountInRow(widget.shop.id, discountAmount);

    var boldTextStyle = TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);
    var textStyle = TextStyle(fontSize: 22.0);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red[900],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Your order',
                style: TextStyle(),
              ),
              Text(
                  canDeliver
                      ? 'You are good to go'
                      : 'Spend £${remainderAmount.toStringAsFixed(2)} for delivery.',
                  style: TextStyle(fontSize: 16.0)),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              //AllergyBox(),
              subTotal > 0
                  ? Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: OrderList(
                              shopId: widget.shop.id,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              subTotal > 0
                  ? Container(
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                'Subtotal',
                                style: boldTextStyle,
                              ),
                              trailing: Text(
                                '£${Conversion.moneyFormat(subTotal)}',
                                style: boldTextStyle,
                              ),
                            ),
                            canShowOffer
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Offer',
                                          style: TextStyle(
                                              backgroundColor: Colors.orange,
                                              fontSize: 18.0),
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Container(
                                          child: Expanded(
                                            child: Text(
                                              'Get ${widget.shop.percentageDiscount}% off when you spend over £${widget.shop.discountAmount}',
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            discount != "0" &&
                                    discount != "NaN" &&
                                    discount != 0
                                ? ListTile(
                                    title: Text(
                                      'Discount',
                                      style: textStyle,
                                    ),
                                    trailing: Text(
                                        '- £${Conversion.moneyFormat(discount)}',
                                        style: textStyle),
                                  )
                                : Text(""),
                            ListTile(
                              title: Text(
                                'Delivery fee',
                                style: textStyle,
                              ),
                              trailing: Text(
                                  '£${Conversion.moneyFormat(deliveryPrice)}',
                                  style: textStyle),
                            ),
                            ListTile(
                              title: Text('Total', style: boldTextStyle),
                              trailing: Text(
                                  '£${Conversion.moneyFormat(total)}',
                                  style: boldTextStyle),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            child: Icon(
                              Icons.shopping_basket,
                              size: 50.0,
                            ),
                            backgroundColor: Colors.blueGrey,
                            radius: 50.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Text(
                            'Your order is empty',
                            style: boldTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Back to menu',
                              style: TextStyle(
                                color: Colors.red[900],
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        bottomNavigationBar: subTotal > 0
            ? Padding(
                padding: EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: subTotal >= minOrder
                      ? () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                    shop: widget.shop,
                                    total: total.toString(),
                                  )));
                        }
                      : null,
                  color: Colors.red[900],
                  textColor: Colors.white,
                  child: Text('Proceed to payment'),
                ),
              )
            : Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(""),
              ));
  }
}
