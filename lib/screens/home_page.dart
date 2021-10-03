import 'package:flutter/material.dart';
import 'package:foodengo/provider/providerData.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../widgets/foodListing.dart';
import '../widgets/app_drawer.dart';
import '../services/api_service.dart';
import '../utility/constant.dart';
import '../services/google_places_service.dart';
import 'dart:async';
import 'dart:math';
import '../models/shop.dart';
import 'package:location/location.dart';

const kGoogleApiKey = "AIzaSyAxzqWxAPLa84wZleSF86Ycih79Of47ZKo";

//import '../widgets/home_top_info.dart';
//import '../widgets/food_category.dart';
//import '../widgets/search_file.dart';

// Model

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

// String _currentAddress;
double _longitude;
double _latitude;
bool serviceEnabled;

class HomePage extends StatefulWidget {
  static String routeName = "homePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Food> _foods = foods;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  //List<Category> categoryList;
  ApiService api = ApiService();
  List<Shop> shopList;
  @override
  void initState() {
    super.initState();

    // try {
    //   getCurrentLocation().then((Position position) => {

    //         // _latitude = position.latitude,
    //         // _longitude = position.longitude,
    //         // print(position.latitude)
    //         // FlutterSession().set(longitude, position.longitude),
    //         // FlutterSession().set(latitude, position.latitude)
    //       });
    // } catch (err) {
    //   print("error!");
    // }
  }

  bool _hasLoaded = false;
  @override
  Widget build(BuildContext context) {
    getCurrentLocation(context);
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Store Listing'),
        actions: <Widget>[
          GestureDetector(
              onTap: () async {
                await GooglePlaceService.showPlaces(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.add_location_alt_outlined,
                  color: Colors.white,
                  size: 30.0,
                ),
              )),
        ],
      ),
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: <Widget>[
          // HomeTopInfo(),
          SizedBox(
            height: 50.0,
          ),
          // //FoodCategory(),
          // SizedBox(
          //   height: 20.0,
          // ),
          // SearchField(),
          // SizedBox(
          //   height: 20.0,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text(
          //       "Vendor Listing",
          //       style: TextStyle(
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 20.0),
          FoodListing(_latitude, _longitude),
        ],
      ),
    );
  }

  void getCurrentLocation(BuildContext context) async {
    //checks hasloaded so this can't be infinite
    if (!_hasLoaded) {
      setState(() {
        _hasLoaded = true;
      });
      Location location = new Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          await GooglePlaceService.showPlaces(context);
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          await GooglePlaceService.showPlaces(context);
          return;
        }
      }

      _locationData = await location.getLocation();
      double _lat = _locationData.latitude;
      double _lng = _locationData.longitude;
      Provider.of<ProviderData>(context).setPosition(
          double.parse(_lat.toString()), double.parse(_lng.toString()));

      List<Placemark> p = await geolocator.placemarkFromCoordinates(_lat, _lng);
      Placemark place = p[0];
      print("locality ------------------${place.locality}");
      // PermissionStatus permission =
      //     await LocationPermissions().checkPermissionStatus();

      // // Test if location services are enabled.
      // //serviceEnabled = await Geolocator.isLocationServiceEnabled();

      // geolocator
      //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      //     .then((Position position) async {
      //   setState(() {
      //     _currentPosition = position;
      //   });
      //   // print("set postion $latitude $longitude");
      //   //Location location = new Location();
      //   //_locationData = await location.getLocation();
      //   Provider.of<ProviderData>(context).setPosition(
      //       double.parse(position.latitude.toString()),
      //       double.parse(position.longitude.toString()));

      //   // _getAddressFromLatLng();
      // }).catchError((e) {
      //   GooglePlaceService.showPlaces(context);
      //   if (permission == PermissionStatus.denied) {
      //     print("permission denied");
      //   }
      //   print(e);
      // });
    }
  }
}
