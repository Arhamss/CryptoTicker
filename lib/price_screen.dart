import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/repository/crypto_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'models/crypto_prices_model.dart';

String? fcurrency = 'PKR';

List<Text> currencyList = [];

void populateCurr() {
  for (int i = 0; i < 22; i++) {
    currencyList.add(Text(currenciesList[i]));
  }
}

class PriceScreen extends StatefulWidget {
  const PriceScreen({
    super.key,
  });

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int index = 14;
  String selectedCurrency = 'AUD';
  List<String> price = [];
  Map<String, String> cryptoRates = {};
  List<CryptoPrices> cryptoPrices = [];
  late FixedExtentScrollController scrollController;

  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (int i = 0; i < currenciesList.length; i++) {
      var newItem = DropdownMenuItem(
        value: currenciesList[i],
        child: Text(currenciesList[i]),
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) {
          if (value != null) {
            setState(() {
              cryptoPrices = [];
              selectedCurrency = value;
            });
          }
        });
  }

  CupertinoPicker iOSPicker() {
    for (int i = 0; i < currenciesList.length; i++) {
      currencyList.add(Text(currenciesList[i]));
    }

    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: 14),
      backgroundColor: Colors.lightBlue,
      selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
        background: Colors.transparent,
      ),
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) async {
        setState(() {
          cryptoPrices = [];
          selectedCurrency = currenciesList[selectedIndex];
        });
      },
      children: currencyList,
    );
  }

  Widget buildPicker() => SizedBox(
        height: 350,
        child: CupertinoPicker(
          scrollController: scrollController,
          looping: true,
          itemExtent: 32,
          onSelectedItemChanged: (int value) {
            setState(() {
              cryptoPrices = [];
              selectedCurrency = currenciesList[value % 22];
            });
          },
          children: currencyList,
        ),
      );
  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    populateCurr();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEB1555),
        title: const Text('Cryptocurrency Price'),
        leading: IconButton(
          onPressed: () {
            setState(() {
              cryptoPrices = [];
              CryptoRepository.getCryptoPrices(currency: selectedCurrency);
            });
          },
          icon: const Icon(
            Icons.refresh,
            color: Color(0xFFECE9E9),
            size: 35,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.attach_money,
              color: Color(0xFFECE9E9),
              size: 35,
            ),
            onPressed: () {
              setState(() {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: Text(
                      'Change Currency to: $selectedCurrency',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      buildPicker(),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Go Back'),
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: FutureBuilder<List<CryptoPrices>>(
                  future: CryptoRepository.getCryptoPrices(
                      currency: selectedCurrency),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      cryptoPrices = snapshot.data!;
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cryptoPrices.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CryptoCard(
                              image: cryptoPrices[index].image!,
                              cryptoAbbrev: cryptoPrices[index].name!,
                              price: cryptoPrices[index]
                                  .currentPrice!
                                  .toStringAsFixed(1),
                              currency: selectedCurrency,
                            );
                          });
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return const Center(
                        child: Text('An Error Occurred While Fetching Data'),
                      );
                    }
                  }),
            ),
            // Container(
            //   height: 150.0,
            //   alignment: Alignment.center,
            //   padding: const EdgeInsets.only(bottom: 30.0),
            //   color: Colors.lightBlue,
            //   child: Platform.isIOS ? iOSPicker() : androidPicker(),
            // ),
          ],
        ),
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    required this.image,
    required this.cryptoAbbrev,
    required this.price,
    required this.currency,
  });

  final String cryptoAbbrev;
  final String price;
  final String image;
  final String currency;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1D1E33),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cryptoAbbrev,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Amount: 1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFFB2B2B2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '$price $currency',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
