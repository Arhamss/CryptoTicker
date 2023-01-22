// import 'package:bitcoin_ticker/price_screen.dart';
// import 'package:bitcoin_ticker/repository/crypto_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'coin_data.dart';
// import 'models/crypto_prices_model.dart';
//
// class LoadingScreen extends StatefulWidget {
//   @override
//   _LoadingScreenState createState() => _LoadingScreenState();
// }
//
// class _LoadingScreenState extends State<LoadingScreen> {
//   void getCryptoData() async {
//     final CryptoPrices cryptoPrices =
//         await CryptoRepository.getCryptoPrices(currency: 'PKR');
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) {
//           return PriceScreen(
//             cryptoPrices: cryptoPrices,
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCryptoData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: SpinKitPouringHourGlassRefined(
//           color: Colors.tealAccent,
//           size: 100,
//         ),
//       ),
//     );
//   }
// }
