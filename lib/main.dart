import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Isw Webview Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController _webViewController;
  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  void _initializeWebView(WebViewController wb) {
    const String iswContent = '''
    <html>
      <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="/docs/4.0/assets/img/favicons/favicon.ico">
    
        <title>Inline Checkout</title>
    
        <link rel="canonical" href="https://getbootstrap.com/docs/4.0/examples/checkout/">
    
        <!-- Bootstrap core CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
    
        <!-- Custom styles for this template -->
        <link href="form-validation.css" rel="stylesheet">
    </head>
      <body class="bg-light">
        <div class="container">
        <div class="py-5 text-center">
            <h2>Checkout form</h2>
            <p class="lead">Integrating to Interswitch Payment Gateway - Redirect</p>
        </div>
    
        <div class="row">
            <div class="col-md-4 order-md-2 mb-4">
                <h4 class="d-flex justify-content-between align-items-center mb-3">
                    <span class="text-muted">Your cart</span>
                    <span class="badge badge-secondary badge-pill">2</span>
                </h4>
                <ul class="list-group mb-3">
                    <li class="list-group-item d-flex justify-content-between lh-condensed">
                        <div>
                            <h6 class="my-0">Product name</h6>
                            <small class="text-muted">Brief description</small>
                        </div>
                        <span class="text-muted">₦100</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between lh-condensed">
                        <div>
                            <h6 class="my-0">Second product</h6>
                            <small class="text-muted">Brief description</small>
                        </div>
                        <span class="text-muted">₦200</span>
                    </li>
    
                    <li class="list-group-item d-flex justify-content-between">
                        <span>Total (Naira)</span>
                        <strong>₦300</strong>
                    </li>
                </ul>
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Promo code">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-secondary">Redeem</button>
                    </div>
                </div>
    
            </div>
            <div class="col-md-8 order-md-1">
                <h4 class="mb-3">Billing Information</h4>
    
              <!-- Form containing POST parameters -->
    
    
                    <!-- Hidden parameters containing interswitch merchant credentials -->
                    <input type="hidden"  name='amount' value="30000"/>
                    <input type="hidden"  name='currency' value="566"/>
                    <input type="hidden" name='txn_ref' id="tranRef"/>
                    <input type="hidden"  name='merchant_code'/>
                    <input type="hidden"  name='pay_item_id'/>
                    <input type="hidden"  name='site_redirect_url'/>
                    <input type="hidden"  name='display_mode' value='PAGE'/>
                    <!-- Hidden parameters end -->
    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName">First name</label>
                            <input name="" type="text" class="form-control" id="firstName" placeholder="" value="" required>
                            <div class="invalid-feedback">
                                Valid first name is required.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName">Last name</label>
                            <input name="" type="text" class="form-control" id="lastName" placeholder="" value="" required>
                            <div class="invalid-feedback">
                                Valid last name is required.
                            </div>
                        </div>
                    </div>
    
    
                    <div class="mb-3">
                        <label for="email">Email <span class="text-muted">(Optional)</span></label>
                        <input name="cust_id" type="email" value="test@mail.com" class="form-control" id="email" placeholder="you@example.com">
                        <div class="invalid-feedback">
                            Please enter a valid email address for shipping updates.
                        </div>
                    </div>
    
                    <div class="mb-3">
                        <label for="address">Address</label>
                        <input type="text" class="form-control" id="address" placeholder="1234 Main St" required>
                        <div class="invalid-feedback">
                            Please enter your shipping address.
                        </div>
                    </div>
    
                    <div class="mb-3">
                        <label for="address2">Address 2 <span class="text-muted">(Optional)</span></label>
                        <input type="text" class="form-control" id="address2" placeholder="Apartment or suite">
                    </div>
    
    
                    <hr class="mb-4">
    
                    <h4 class="mb-3">Payment</h4>
                    <hr class="mb-4">
                    <button style="border: 1px solid rgb(206, 206, 206);
            height: 40px;
            margin: 0;
            box-shadow: rgb(226, 224, 224) 0px 1px 3px;
            padding: 0 2em 0 0.8em;
            font-weight: 700;
            border-radius: 4px;
            color: rgb(0, 66, 95);
            font-size: 13px;
            text-transform: uppercase;
            background-color: #FFF;
            background-image: url(https://paymentgateway.interswitchgroup.com/paymentgateway/public/images/isw_paynow_btnbg.png);
            width: 260px;
            display: inline-block;
            box-sizing: border-box;
            cursor: pointer;
            font-family: 'proxima-nova', sans-serif, 'Helvetica';" onclick="checkout()">
                        <img style="float:left;" class="isw-pay-logo"
                             src="https://paymentgateway.interswitchgroup.com/paymentgateway/public/images/isw_paynow_btn.png"/>
                        <span style="margin-top: 10px;display: inline-block;margin-left: 8px;">
                Pay with Interswitch
              </span>
                    </button>
    
            </div>
        </div>
    
        <footer class="my-5 pt-5 text-muted text-center text-small">
            <p class="mb-1">&copy; 2020 Interswitch Group</p>
    
        </footer>
    </div>
    </body>
    
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
            crossorigin="anonymous"></script>
        <script src="https://webpay-ui.k8.isw.la/inline-checkout.js"></script>
      <body>
      <script type="text/javascript">
        //load isw payment page
            function checkout(){
              var merchantCode = 'MX19329';
              var payItemId = 'Default_Payable_MX19329';
    
              var transRef = randomReference();
              var paymentRequest = {
                    merchant_code: merchantCode,
                    pay_item_id: payItemId,
                    txn_ref: transRef,
                    amount:  document.getElementsByName('amount')[0].value,
                    cust_id: document.getElementsByName('cust_id')[0].value,
                    currency:  document.getElementsByName('currency')[0].value,
                    site_redirect_url: window.location.origin,
                    onComplete: paymentCallback,
                    mode: 'TEST'
                  };
               window.webpayCheckout(paymentRequest);
            }
    
            //generate a random transaction ref
            function randomReference() {
              var length = 10;
              var chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
              var result = '';
              for (var i = length; i > 0; --i) result += chars[Math.floor(Math.random() * chars.length)];
              return result;
            }
    
            //callback function that gets triggered on payment success or failure
            function paymentCallback(response){
                if(response != null){
                    alert(response.desc);
                }
        
            }
    </script>
    </html>
    ''';

    setState(() {
      _webViewController = wb;
    });

    _webViewController.loadUrl(
      Uri.dataFromString(iswContent,
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: _initializeWebView,
      ),
    );
  }
}
