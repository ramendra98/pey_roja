import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Razorpay razorpay;
  TextEditingController _payeControllar = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }
//UYQHD4RbsLsWkLByDL1jCq7O
  void openCheckOut() {
    var option = {
      "key": "rzp_test_ftvtD9IOKXLSBE",
      "amount": num.parse(_payeControllar.text)*100,
      "name": "RAMENDAR PATEL",
      "description": "Payment for the some random Product",
      "prefill": {"contact": "7905114087", "email": "ramendrapatelcse98@gmail.com"},
      "external":{
        "wallets":["Paytm"]
      }
    };
    try{
razorpay.open(option);
    }
    catch(e){
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print("Payment Success");
    Toast.show("Payment Success",context);
  }

  void handlerErrorFailure() {
    print("Payment Error");
    Toast.show("Payment Error",context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
Toast.show("External Wallet",context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razir Pay "),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _payeControllar,
              decoration: InputDecoration(hintText: 'Amount'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            onPressed: () {
              openCheckOut();
            },
            color: Colors.blueAccent,
            child: Text(
              'Pay Now',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
