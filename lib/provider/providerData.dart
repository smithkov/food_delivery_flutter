import 'package:flutter/foundation.dart';
import '../models/shopCart.dart';
import '../models/productCounter.dart';
import '../models/productCart.dart';
import '../services/api_advance.dart';
import '../services/api_service.dart';
import '../models/serialize/cartSerial.dart';
import '../models/user.dart';
import '../utility/conversions.dart';

class ProviderData extends ChangeNotifier {
  List<ShopCart> store = [];
  List<ProductCounter> counters = [];
  User userData;
  int counter = 4;
  var deliveryPrice;
  var discountAmount;
  var discountPercentage;
  var shopId;
  var _longitude;
  var _latitude;
  List<CartSerial> orderList = [];

  Map<String, dynamic> dbProduct({String id, String quantity, String price}) {
    return {
      "id": id,
      "quantity": quantity,
      "price": price,
    };
  }

  dynamic getDeliveryPrice() {
    return deliveryPrice;
  }

  void _loadUserData() async {
    if (userData == null) {
      var user = await ApiService.getUserData();
      userData = user;
      notifyListeners();
    }
  }

  void setPosition(lat, long) {
    _latitude = lat;
    _longitude = long;
    notifyListeners();
  }

  dynamic getDistance(storeLat, storeLong) {
    print("-------$_latitude  $_longitude");
    print("-----ee--$storeLat  $storeLong");
    if (_longitude != null && _latitude != null)
      return Conversion.getMiles2(storeLat, storeLong, _latitude, _longitude);
    else
      return 0.0;
  }

  User userDetail() {
    _loadUserData();
    return userData;
  }

  void loadShopCart({String shopId}) async {
    ShopCart findShop =
        store.firstWhere((item) => item.shopId == shopId, orElse: () => null);

    if (findShop == null) {
      var cart = await ApiService.retriveCart(shopId);
      if (cart.orders.length == 0) {
        return;
      }
      findShop = ShopCart(shopId: shopId);
      if (cart.orders.length > 0) {
        cart.orders.forEach((value) {
          findShop.addProduct(
              shopId: shopId,
              id: value.id,
              name: value.name,
              price: double.parse(value.price.toString()),
              quantity: int.parse(value.quantity.toString()));

          counters.add(ProductCounter(
              productId: value.id, counter: value.quantity, hasItem: true));

          store.add(findShop);
        });
        notifyListeners();
      }
    }
  }

  void addProduct(String id, String productId, double price, String name,
      int quantity, String photo, String desc, String weight) async {
    ShopCart findShop =
        store.firstWhere((item) => item.shopId == id, orElse: () => null);

//    if(findShop == null){
//    ShopCart myCart = ShopCart(shopId: id);
//    myCart.addProduct(id, productId,name, quantity, price);
//
//    store.add(myCart);
////
//    }
//    else{

    // }
    if (findShop == null) {
      ShopCart myCart = ShopCart(shopId: id);

      myCart.addProduct(
          shopId: id,
          id: productId,
          name: name,
          quantity: quantity,
          price: price,
          desc: desc,
          weight: weight,
          photo: photo);
      store.add(myCart);
    } else {
      ProductCart products = findShop.products
          .firstWhere((item) => item.id == productId, orElse: () => null);
      if (products == null) {
        findShop.addProduct(
            shopId: id,
            id: productId,
            name: name,
            quantity: quantity,
            price: price,
            desc: desc,
            weight: weight,
            photo: photo);
      } else {
        products.quantity = quantity;
      }
    }

    //mark counter to true after adding
    ProductCounter counter = getProductCounterById(productId);
    if (counter != null) {
      counter.hasItem = true;
    } else {
      counters.add(ProductCounter(
          productId: productId, counter: quantity, hasItem: true));
    }

    saveCartToDatabase(
        price: price.toString(),
        productId: productId.toString(),
        quantity: quantity.toString(),
        shopId: id);

    notifyListeners();
  }

  void saveCartToDatabase(
      {String productId, String quantity, String price, String shopId}) async {
    var getDiscount =
        discount(discountPercentage, discountAmount, deliveryPrice, shopId);
    var total =
        grandTotal(discountPercentage, discountAmount, deliveryPrice, shopId);

    var subTotal = getTotalShopAmount(shopId);

    var shopOrders = productList(shopId);
    shopOrders.forEach((value) {
      orderList.add(CartSerial(
          id: value.id,
          quantity: value.quantity.toString(),
          price: value.price,
          name: value.name));
    });
    await ApiAdvance.addToCart(
        deliveryPrice: deliveryPrice.toString(),
        offerDiscount: getDiscount.toString(),
        id: shopId,
        orders: orderList,
        subTotal: subTotal.toString(),
        total: total.toString());

    orderList.clear();
  }

  //this will be used by stores
  ShopCart getStoreCart(String shopId) {
    ShopCart findShop = getShopById(shopId);
    if (findShop == null) {
      return ShopCart(shopId: shopId);
    } else
      return findShop;
  }

  double getRemainderAmount(double minOrder, shopId) {
    return minOrder - double.parse(getTotalShopAmount(shopId));
  }

  void updateForCart(
      {var delPrice = 0, var discAmount = 0, discPercent = 0, shpId}) {
    deliveryPrice = double.parse(delPrice);
    discountAmount = double.parse(discAmount);
    discountPercentage = double.parse(discPercent);
    shopId = shpId;
    notifyListeners();
  }

  String getShopId() {
    return shopId;
  }

  bool canShowOffer(double discountPercent, double discountAmount, shopId) {
    double subTotal = double.parse(getTotalShopAmount(shopId));
    if (discountPercent > 0 && discountAmount > 0) {
      if (subTotal < discountAmount) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool canDeliver(shopId, double minOrder) {
    return double.parse(getTotalShopAmount(shopId)) >= minOrder;
  }

  bool canDiscountInRow(shopId, double discountAmount) {
    double subTotal = double.parse(getTotalShopAmount(shopId));

    return double.parse(getTotalShopAmount(shopId)) <= discountAmount;
  }

  double grandTotal(double discountPercent, double discountAmount,
      double deliveryPrice, String shopId) {
    double subTotal = double.parse(getTotalShopAmount(shopId));
    if (discountPercent > 0 && discountAmount > 0) {
      if (subTotal > discountAmount) {
        double percentage = (discountPercent / 100);
//
        return (deliveryPrice + subTotal) - (percentage * subTotal);
      }
    }
    return deliveryPrice + subTotal;
  }

  double discount(double discountPercent, double discountAmount,
      double deliveryPrice, String shopId) {
    double subTotal = double.parse(getTotalShopAmount(shopId));
    if (discountPercent > 0 && discountAmount > 0) {
      if (subTotal > discountAmount) {
        double percentage = (discountPercent / 100);
        return (percentage * subTotal);
      }
    }
    return 0;
  }

  int getTotalShopQuantity(String shopId) {
    int _counter = 0;
    ShopCart findShop = getShopById(shopId);
    if (findShop == null || findShop.products.length < 1) {
      return 0;
    }

    for (final product in findShop.products) {
      //
      _counter = _counter + product.quantity;
    }
    return _counter;
  }

  String getTotalShopAmount(String shopId) {
    double _total = 0;
    ShopCart findShop = getShopById(shopId);
    if (findShop == null || findShop.products.length < 1) {
      return _total.toStringAsFixed(2);
    }

    for (final product in findShop.products) {
      //
      _total = _total + product.quantity * product.price;
    }
    return _total.toStringAsFixed(2);
  }

  ProductCounter getProductQuantity(String productId) {
    ProductCounter counter = getProductCounterById(productId);
    if (counter == null)
      return new ProductCounter(
          productId: productId, counter: 0, hasItem: false);

    return counter;
  }

  void updateProductQuantity(String productId, String quantity) {
    ProductCounter counter = getProductCounterById(productId);

    if (counter == null) {
      counters.add(ProductCounter(
          productId: productId, counter: quantity, hasItem: false));
    } else {
      counter.counter = quantity;
    }

    notifyListeners();
  }

  List<ProductCart> productList(String shopId) {
    ShopCart shop =
        store.firstWhere((item) => item.shopId == shopId, orElse: () => null);
    if (shop != null) {
      return shop.products;
    } else {
      return null;
    }
  }

  ShopCart getShopById(String shopId) {
    return store.firstWhere((item) => item.shopId == shopId,
        orElse: () => null);
  }

  ProductCounter getProductCounterById(String productId) {
    return counters.firstWhere((item) => item.productId == productId,
        orElse: () => null);
  }

  ProductCart getProductById(String productId, shopId) {
    ShopCart shop =
        store.firstWhere((item) => item.shopId == shopId, orElse: () => null);
    if (shop == null)
      return null;
    else
      return shop.products
          .firstWhere((item) => item.id == productId, orElse: () => null);
  }

  void removeProduct(String shopId, String productId) async {
    ShopCart findShop = getShopById(shopId);
    ProductCart product = findShop.products
        .firstWhere((item) => item.id == productId, orElse: () => null);

    findShop.products.remove(product);

    ProductCounter productCounter = counters
        .firstWhere((item) => item.productId == productId, orElse: () => null);

    counters.remove(productCounter);

    notifyListeners();
  }
}
