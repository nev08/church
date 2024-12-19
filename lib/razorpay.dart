import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  TextEditingController amtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();  // Clean up the controller when the page is disposed
  }

  // Handlers for Razorpay events
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment Successful: ${response.paymentId}");
    debugPrint('Payment Successful: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed: ${response.code} | ${response.message}");
    debugPrint('Payment failed with code: ${response.code}, message: ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "External Wallet: ${response.walletName}");
    debugPrint('External Wallet: ${response.walletName}');
  }

  // Initiate the Razorpay payment
  void openCheckout() {
    var amount = int.tryParse(amtController.text) ?? 0; // Get amount from user input

    if (amount <= 0) {
      Fluttertoast.showToast(msg: "Please enter a valid amount");
      return;
    }

    var options = {
      'key': 'rzp_test_1DP5mm0lF5G5ag', // Test key
      'amount': amount * 100, // Amount is in paise
      'name': 'Your App Name',
      'description': 'Donation Payment',
      'prefill': {
        'contact': '1234567890', // Customer's phone number
        'email': 'test@gmail.com',  // Customer's email
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
      debugPrint('Error during payment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: amtController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Amount (₹)',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: openCheckout,
              child: Text('Donate'),
            ),
          ],
        ),
      ),
    );
  }
}
