import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:foodengo/provider/providerData.dart';
import 'package:foodengo/screens/home_page.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:provider/provider.dart';
import '../utility/constant.dart';

class GooglePlaceService {
  static final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  static Mode _mode = Mode.overlay;
  static void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  static Future<void> showPlaces(BuildContext context) async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: "en",
        components: [Component(Component.country, "gb")]);

    return _displayPrediction(p, homeScaffoldKey.currentState, context);
  }

  static Future<Null> _displayPrediction(
      Prediction p, ScaffoldState scaffold, BuildContext context) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      await FlutterSession().set(address, p.description.toString());
      await FlutterSession().set(latitude, lat.toString());
      await FlutterSession().set(longitude, lng.toString());
      Provider.of<ProviderData>(context).setPosition(lat, lng);

      // scaffold.showSnackBar(
      //   SnackBar(content: Text("${p.description} - $lat/$lng")),
      // );
    }
  }
}
