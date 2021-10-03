import 'package:foodengo/widgets/productList.dart';
import '../models/shopCart.dart';
import '../models/item.dart';
import 'package:flutter/material.dart';
import '../models/shop.dart';
import '../screens/orderListPage.dart';
import '../screens/home_page.dart';
import '../widgets/allergyBox.dart';
import '../services/api_service.dart';
import '../utility/constant.dart';
import '../provider/providerData.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';

class StorePage extends StatefulWidget {
  // final FoodModel foodModel;
  final Shop shop;

  StorePage({
    this.shop,
  });

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  ShopCart cart;
  var _deliveryPrice;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyFunctions.generateTempId();
  }

  final ApiService api = ApiService();
  bool _canCoverDistance = true;
  bool _hasLoaded = false;
  void fetchDelivery(String shopId, String distance) async {
    if (!_hasLoaded) {
      _hasLoaded = true;
      var delPrice = await ApiService.fetchDeliveryPriceByDistance(
          distance.toString(), shopId);

      setState(() {
        _deliveryPrice = delPrice["price"].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final shop = widget.shop;
    final _latitude = shop.latitude != null ? double.parse(shop.latitude) : null;
    final _longitude =
        shop.latitude != null ? double.parse(shop.longitude) : null;

    final _distance = _latitude != null && _longitude != null
        ? Provider.of<ProviderData>(context).getDistance(_latitude, _longitude)
        : "";

    if (shop.hasMultipleDelivery) {
      if (_latitude != null && _longitude != null) {
        if (double.parse(_distance) > double.parse(shop.deliveryDistance)) {
          print("Nooooo");
          setState(() {
            _canCoverDistance = false;
            _deliveryPrice = shop.deliveryPrice;
          });
        } else {
          print("Ayeeee");
          fetchDelivery(shop.id, _distance);
        }
      }
    }
    final minOrder = shop.minOrder;
    final percentageDiscount = shop.percentageDiscount;
    final discountAmount = shop.discountAmount;

    final cartTextStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);

    String total =
        Provider.of<ProviderData>(context).getTotalShopAmount(shop.id);
    int totalQuantity =
        Provider.of<ProviderData>(context).getTotalShopQuantity(shop.id);
    cart = Provider.of<ProviderData>(context).getStoreCart(shop.id);

    double width = MediaQuery.of(context).size.width;

    final textStyle = TextStyle(fontSize: 18.0);
    _canCoverDistance
        ? Text("")
        : Future.delayed(Duration.zero, () => _showAlert(context));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(shop.shopName),
      ),
      body: ListView(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              height: 230.0,
              child: Image.network(
                shop.banner == null ? defaultBannerUrl : shop.banner,
                width: width,
                fit: BoxFit.fitWidth,
                height: 90,
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 0.0,
              right: 10.0,
              child: Center(
                child: Image.network(
                  shop.logo,
                  width: 90,
                  fit: BoxFit.fitWidth,
                  height: 90,
                ),
              ),
            ),
          ]),
          Center(
            child: Text(
              shop.shopName,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.red,
                ),
                Icon(
                  Icons.star,
                  color: Colors.red,
                ),
                Icon(
                  Icons.star,
                  color: Colors.red,
                ),
                Icon(
                  Icons.star,
                  color: Colors.red,
                )
              ],
            ),
          ),
          Center(
              child: percentageDiscount != null &&
                      percentageDiscount != "0" &&
                      percentageDiscount != "" &&
                      percentageDiscount != "0.00"
                  ? Text(
                      '$percentageDiscount % off when you spend £${shop.discountAmount}',
                      style: TextStyle(
                          fontSize: 18.0, backgroundColor: Colors.yellowAccent),
                    )
                  : Text("")),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _deliveryPrice != null &&
                          _deliveryPrice != "0" &&
                          _deliveryPrice != "NaN" &&
                          _deliveryPrice != "0.00"
                      ? Text(
                          '£$_deliveryPrice delivery fee',
                          style: textStyle,
                        )
                      : Text('Free Delivery'),
                  (minOrder != null &&
                          minOrder != "NaN" &&
                          minOrder != "0" &&
                          minOrder != "0.00")
                      ? Text('£$minOrder min order', style: textStyle)
                      : Text("")
                ],
              )),
          AllergyBox(
            phone: shop.phone,
          ),
          Center(
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          // Expanded(
          //     child: ItemPage(
          //   itemId: widget.shop.id,
          // )),
          Row(
            children: [
              Expanded(
                child: FutureBuilder<List<Item>>(
                  future: api.getProductByShop(shop.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);

                    return snapshot.hasData
                        ? ProductList(
                            products:
                                snapshot.data) // return the ListView widget
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: totalQuantity != 0
          ? GestureDetector(
              onTap: () {
                print(
                    "delprice $_deliveryPrice  discAmount ${shop.discountAmount}  discPercent ${shop.percentageDiscount}");
                Provider.of<ProviderData>(context).updateForCart(
                    delPrice: _deliveryPrice == null ? "0" : _deliveryPrice,
                    discAmount: shop.discountAmount,
                    discPercent: shop.percentageDiscount,
                    shpId: shop.id);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderListPage(
                          shop: shop,
                        )));
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.red[900],
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 13.0),
                        child: ListTile(
                          title: GFIconBadge(
                            child: GFIconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              shape: GFIconButtonShape.circle,
                              color: Colors.red[900],
                            ),
                            counterChild: GFBadge(
                              child: Text(totalQuantity.toString()),
                              size: GFSize.MEDIUM,
                              textColor: Colors.white,
                              color: Colors.deepOrange,
                            ),
                          ),
                          trailing: Column(
                            children: <Widget>[
                              Text(
                                '£${total.toString()}',
                                style: cartTextStyle,
                              ),
                              Text(
                                'Ready to checkout',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Text(""),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              title: Text(""),
              content: Text(
                "Sorry this shop does not cover your location",
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Center(
                  child: FlatButton(
                    onPressed: () => {
                      // Navigator.pop(context, true),

                      // Navigator.pop(context, 'OK'),
                      Navigator.of(context).pop(),
                      Navigator.of(context).pop(),
                    },
                    child: const Text('Back to Listing'),
                  ),
                ),
              ],
            ));
  }
}
