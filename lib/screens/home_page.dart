import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/api_helpers.dart';
import '../models/api_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<String> currencyCode = [
    "USD",
    "EUR",
    "JPY",
    "AFN",
    "DZD",
    "ARS",
    "AUD",
    "AZN",
    "BDT",
    "ZAR",
    "SGD",
    "INR",
    "UAH",
    "RUB",
    "HKD",
  ];

  late Future<CurrencyConvert?> future;
  TextEditingController textEditingController = TextEditingController();

  bool isIOS = false;

  @override
  void initState() {
    super.initState();
    future = CurrencyConvertAPI.currencyConvertAPI
        .currencyConvertorAPI(from: "USD", to: "INR", amount: 1);

    textEditingController.text = "1";
  }

  String fromCurrency = "USD";
  String toCurrency = "INR";

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return (isIOS)
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Currency Convertor"),
              actions: [
                Switch(
                  value: isIOS,
                  onChanged: (val) {
                    setState(() {
                      isIOS = val;
                    });
                  },
                ),
              ],
            ),
            body: FutureBuilder(
              future: future,
              builder: (context, snapShot) {
                if (snapShot.hasError) {
                  return Center(
                    child: Text("${snapShot.error}"),
                  );
                } else if (snapShot.hasData) {
                  CurrencyConvert? data = snapShot.data;

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: h * 0.03,
                        ),
                        const Text(
                          "Amount  :",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: textEditingController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "From",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.02,
                                ),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  value: fromCurrency,
                                  onChanged: (val) {
                                    setState(() {
                                      fromCurrency = val!;
                                    });
                                  },
                                  items: currencyCode.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "To",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.02,
                                ),
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  value: toCurrency,
                                  onChanged: (val) {
                                    setState(() {
                                      toCurrency = val!;
                                    });
                                  },
                                  items: currencyCode.map((e) {
                                    return DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: h * 0.07,
                          width: w * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue.shade500,
                          ),
                          child: Text(
                            "Result: ${data!.result}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            int amt = int.parse(textEditingController.text);
                            setState(() {
                              future = CurrencyConvertAPI.currencyConvertAPI
                                  .currencyConvertorAPI(
                                from: fromCurrency,
                                to: toCurrency,
                                amount: amt,
                              );
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: h * 0.07,
                            width: w * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue.shade500,
                            ),
                            child: const Text(
                              "CONVERT",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        : CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                trailing: CupertinoSwitch(
                    activeColor: CupertinoColors.activeBlue.withOpacity(0.5),
                    onChanged: (val) {
                      setState(() {
                        isIOS = val;
                      });
                    },
                    value: isIOS),
                backgroundColor: Colors.blue,
                middle: const Text(
                  "Currency Convertor",
                  style: TextStyle(
                    color: CupertinoColors.white,
                  ),
                ),
              ),
              child: FutureBuilder(
                future: future,
                builder: (context, snapShot) {
                  if (snapShot.hasError) {
                    return Center(
                      child: Text("${snapShot.error}"),
                    );
                  } else if (snapShot.hasData) {
                    CurrencyConvert? data = snapShot.data;

                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: h * 0.03,
                          ),
                          const Text(
                            "Amount  :",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: CupertinoTextField(
                                controller: textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "From",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) => Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            height: h * 0.5,
                                            child: CupertinoPicker(
                                              offAxisFraction: 1,
                                              backgroundColor: Colors.white,
                                              itemExtent: 40,
                                              children: currencyCode.map((e) {
                                                return Text(e);
                                              }).toList(),
                                              onSelectedItemChanged: (value) {
                                                setState(() {
                                                  fromCurrency =
                                                      currencyCode[value];
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: h * 0.07,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: w * 0.04,
                                          ),
                                          Text(
                                            fromCurrency,
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            CupertinoIcons.chevron_down_square,
                                          ),
                                          SizedBox(
                                            width: w * 0.04,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "To",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) => Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: SizedBox(
                                                  height: h * 0.5,
                                                  child: CupertinoPicker(
                                                    offAxisFraction: 1,
                                                    backgroundColor:
                                                        Colors.white,
                                                    itemExtent: 40,
                                                    children:
                                                        currencyCode.map((e) {
                                                      return Text(e);
                                                    }).toList(),
                                                    onSelectedItemChanged:
                                                        (value) {
                                                      setState(() {
                                                        fromCurrency =
                                                            currencyCode[value];
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ));
                                    },
                                    child: Container(
                                      height: h * 0.07,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: w * 0.04,
                                          ),
                                          Text(
                                            toCurrency,
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            CupertinoIcons.chevron_down_square,
                                          ),
                                          SizedBox(
                                            width: w * 0.04,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: h * 0.07,
                            width: w * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue.shade500,
                            ),
                            child: Text(
                              "Result: ${data!.result}",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          GestureDetector(
                            onTap: () {
                              int amt = int.parse(textEditingController.text);
                              setState(() {
                                future = CurrencyConvertAPI.currencyConvertAPI
                                    .currencyConvertorAPI(
                                  from: fromCurrency,
                                  to: toCurrency,
                                  amount: amt,
                                );
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: h * 0.07,
                              width: w * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue.shade500,
                              ),
                              child: const Text(
                                "CONVERT",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          );
  }
}
