import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
import '../provider/providerData.dart';
import '../models/productCounter.dart';
import '../screens/signin_page.dart';

class ItemDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ItemDetailState();
  }

  final dynamic id;
  final dynamic name;
  final dynamic price;
  final dynamic photo;
  final dynamic desc;
  final dynamic weight;
  final dynamic shopId;

  ItemDetail(
      {this.id,
      this.name,
      this.price,
      this.photo,
      this.desc,
      this.weight,
      this.shopId});
}

class _ItemDetailState extends State<ItemDetail> {
  int itemCounter = 1;
  ProductCounter counterState;
  double total;
  String buttonText;
  var hasLogedIn = false;

  void checkForLogin() async {
    var hasLogin = await FlutterSession().get("hasLogIn");

    if (hasLogin == true) {
      setState(() {
        hasLogedIn = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkForLogin();
  }

  @override
  Widget build(BuildContext context) {
    counterState =
        Provider.of<ProviderData>(context).getProductQuantity(widget.id);

    itemCounter = int.parse(counterState.counter.toString()) == 0
        ? 1
        : int.parse(counterState.counter);
    total = double.parse(widget.price) * itemCounter;
    buttonText =
        counterState.hasItem == false ? "Add to order" : "Update order";
    String shopId = widget.shopId;
    String productId = widget.id;

    // itemCounter =  counterState;
    //setState(() {

    //});
    //});
    //itemCounter = counterState;
    String newTaskTitle;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detail'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: Color(0xff757575),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            shrinkWrap: true,
            children: <Widget>[
              Container(
                height: 230.0,
                child: Image.network(
                  widget.photo,
                  width: width,
                  fit: BoxFit.fitWidth,
                  height: 90,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  widget.name,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.desc,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text(
                  '£${widget.price}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Colors.red[900],
                        size: 45.0,
                      ),
                      tooltip: 'Increase volume by 10',
                      onPressed: () {
                        setState(() {
                          if (itemCounter > 1) {
                            itemCounter--;
                            total =
                                total - double.parse(widget.price.toString());
                            Provider.of<ProviderData>(context)
                                .updateProductQuantity(
                                    widget.id, itemCounter.toString());
                          }
                        });
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      itemCounter.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 45.0),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.red[900],
                        size: 45.0,
                      ),
                      tooltip: 'Increase volume by 10',
                      onPressed: () {
                        setState(() {
                          itemCounter++;

                          total = itemCounter * double.parse(widget.price);

                          Provider.of<ProviderData>(context)
                              .updateProductQuantity(
                                  widget.id, itemCounter.toString());
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              counterState.hasItem == true
                  ? GestureDetector(
                      onTap: () {
                        Provider.of<ProviderData>(context)
                            .removeProduct(shopId, productId);
                        Navigator.pop(context);
                      },
                      child: Center(
                          child: Text(
                        'Remove from order',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.red[900],
                            fontWeight: FontWeight.bold),
                      )),
                    )
                  : Container(),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (hasLogedIn) {
            Provider.of<ProviderData>(context).addProduct(
                shopId,
                productId,
                double.parse(widget.price),
                widget.name,
                itemCounter,
                widget.photo,
                widget.desc,
                widget.weight);
            Navigator.pop(context);
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => SignInPage()));
          }
        },
        child: Container(
          padding: EdgeInsets.all(20.0),
          color: Colors.red[900],
          height: 80.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                buttonText,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '£${total.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
