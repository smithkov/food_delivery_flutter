import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodengo/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../screens/paymentStatus.dart';
import '../provider/providerData.dart';
import '../utility/constant.dart';

class Checkout_Web extends StatefulWidget {
  final String sessionId;
  const Checkout_Web({Key key, this.sessionId}) : super(key: key);

  @override
  _Checkout_WebState createState() => _Checkout_WebState();
}

class _Checkout_WebState extends State<Checkout_Web> {
  WebViewController _webViewController;
  String apiKey =
      // "pk_test_51HArokCAtyjlhEIMp36IzBHAoMObEl8U4k7XSY9D2btXmb2qAkTo4p5O1DTO8RjNT8RqSh9xas4YVyiUknDxPsa8003xs1iubt";
      "pk_live_51HArokCAtyjlhEIMFCmnQkZZSPo91BusLpi3dSl4Hog2Iki4dg1GOniWhFsIcUgqxmsTVkHg1GFKlEWkK7q7VWsF001plf6XFS";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WebView(
        initialUrl: initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (webViewController) =>
            _webViewController = webViewController,
        onPageFinished: (String url) {
          if (url == initialUrl) {
            _redirectToStripe(widget.sessionId);
          }
        },
        navigationDelegate: (NavigationRequest request) async {
          if (request.url.startsWith('https://success')) {
            var shopId = Provider.of<ProviderData>(context).getShopId();
            bool isError = await ApiService.confirmTransaction(shopId: shopId);
            if (!isError) {
              var createTempId = await MyFunctions.regenerateTempId();
            }
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => PaymentStatus(
                      isError: isError,
                    )));
          } else if (request.url.startsWith('https://error')) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => PaymentStatus(
                      isError: true,
                    )));
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  String get initialUrl => 'https://marcinusx.github.io/test1/index.html';

  Future<void> _redirectToStripe(String sessionId) async {
    final redirectToCheckoutJs = '''
var stripe = Stripe(\'$apiKey\');
    
stripe.redirectToCheckout({
  sessionId: '$sessionId'
}).then(function (result) {
  result.error.message = 'Error'
});
''';

    try {
      await _webViewController.evaluateJavascript(redirectToCheckoutJs);
    } on PlatformException catch (e) {
      if (!e.details.contains(
          'JavaScript execution returned a result of an unsupported type')) {
        rethrow;
      }
    }
  }
}
