import 'package:flutter/material.dart';
import '../models/shop.dart';
import '../services/api_service.dart';
import '../screens/store_page.dart';
import '../utility/constant.dart';
import '../utility/conversions.dart';
import '../provider/providerData.dart';
import 'package:provider/provider.dart';

class FoodListing extends StatefulWidget {
  final double latitude;
  final double longitude;

  FoodListing(this.latitude, this.longitude);

  @override
  _FoodListingState createState() => _FoodListingState();
}

class _FoodListingState extends State<FoodListing> {
  ApiService api = ApiService();

  bool _hasTapped = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double yourWidth = width * 0.95;
    return FutureBuilder<List<Shop>>(
      future: api.getShops(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        return Column(
          children: snapshot.data.map((data) {
            var distance = data.latitude != null && data.longitude != null
                ? Provider.of<ProviderData>(context).getDistance(
                    double.parse(data.latitude), double.parse(data.longitude))
                : "";

            return GestureDetector(
                onTap: () async {
                  if (!_hasTapped) {
                    setState(() {
                      _hasTapped = true;
                    });
                    await Provider.of<ProviderData>(context)
                        .loadShopCart(shopId: data.id);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StorePage(
                              shop: data,
                            )));
                    setState(() {
                      _hasTapped = false;
                    });
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 230.0,
                          width: yourWidth,
                          child: Image(
                            image: NetworkImage(data.banner == null
                                ? defaultBannerUrl
                                : data.banner),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          width: 340.0,
                          height: 60.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter, // 10% of the width, so there are ten blinds.
                                colors: <Color>[
                                  Colors.black38,
                                  Colors.grey
                                ],
                                // begin: Alignment.bottomCenter,
                                // end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10.0,
                          bottom: 10.0,
                          right: 10.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      data.shopName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 16.0,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        (distance != "")
                                            ? Text(
                                                distance.toString() +
                                                    " miles away",
                                                style: TextStyle(
                                                    fontSize: 19.0,
                                                    color: Colors.white),
                                              )
                                            : Text(""),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  data.minOrder != null &&
                                          data.minOrder != "0" &&
                                          data.minOrder != "NaN" &&
                                          data.minOrder != "0.00"
                                      ? Text(
                                          Conversion.moneyFormatForString(
                                              data.minOrder),
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orangeAccent),
                                        )
                                      : Text(""),
                                  data.minOrder != null &&
                                          data.minOrder != "0" &&
                                          data.minOrder != "NaN" &&
                                          data.minOrder != "0.00"
                                      ? Text("Min order",
                                          style: TextStyle(color: Colors.grey))
                                      : Text("")
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }).toList(),
        );
      },
    );
  }
}
