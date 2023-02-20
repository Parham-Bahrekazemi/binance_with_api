import 'package:binance/helpers/decimalRounder.dart';
import 'package:binance/models/CryptoModel/CryptoData.dart';
import 'package:binance/network/response_model.dart';
import 'package:binance/providers/crypto_data_provider.dart';
import 'package:binance/ui/coin_page.dart';
import 'package:binance/ui/ui_helper/theme_switcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'ui_helper/home_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);

  int defaultChoiceIndex = 0;

  final List<String> _choiceList = [
    'Top MarketCaps',
    'Top Gainers',
    'Top Losers',
  ];

  @override
  void initState() {
    super.initState();

    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoProvider.getTopMarketCapData();
  }

  @override
  Widget build(BuildContext context) {
    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    print('height : $height');
    Color primaryColor = Theme.of(context).primaryColor;
    Color primaryColorLight = Theme.of(context).primaryColorLight;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: primaryColorLight == Colors.white
                ? Colors.white
                : Colors.black),
        backgroundColor: primaryColor,
        actions: const <Widget>[
          ThemeSwitcher(),
        ],
        title: const Text(
          'Parham First Project',
        ),
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      HomePageView(pageController: _pageController),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: 4,
                            effect: const WormEffect(
                              dotHeight: 10,
                              dotWidth: 10,
                            ),
                            onDotClicked: (int index) {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(microseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: Marquee(
                  text: 'this is for news in application 🔉',
                  style: textTheme.bodySmall,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.green[700],
                        ),
                        child: const Text('Buy'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(20),
                          backgroundColor: Colors.red[700],
                        ),
                        child: const Text('Sell'),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: Row(
                  children: <Widget>[
                    Wrap(
                      spacing: 8,
                      children: List.generate(
                        _choiceList.length,
                        (int index) => ChoiceChip(
                          label: Text(
                            _choiceList[index],
                            style: textTheme.titleSmall,
                          ),
                          selected: defaultChoiceIndex == index,
                          selectedColor: Colors.blue,
                          onSelected: (bool _) {
                            setState(() {
                              defaultChoiceIndex = index;

                              switch (index) {
                                case 0:
                                  cryptoProvider.getTopMarketCapData();
                                  break;
                                case 1:
                                  cryptoProvider.getTopGainerData();
                                  break;
                                case 2:
                                  cryptoProvider.getTopLoserspData();
                                  break;
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 2.464029850746269,
                child: Consumer<CryptoDataProvider>(
                  builder: (BuildContext context,
                      CryptoDataProvider cryptoDataProvider, Widget? child) {
                    switch (cryptoDataProvider.state.status) {
                      case Status.LOADING:
                        return SizedBox(
                          height: 80,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.white,
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8, bottom: 8, left: 8),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 30,
                                          child: null,
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 50,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 70,
                                                height: 40,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              SizedBox(
                                                width: 50,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        );
                      case Status.COMPLETE:
                        List<CryptoData>? model = cryptoDataProvider
                            .dataFuture.data!.cryptoCurrencyList;

                        return ListView.separated(
                            itemBuilder: (BuildContext context, int index) {
                              var tokenId = model[index].id;
                              MaterialColor filterColor =
                                  DecimalRounder.setColorFilter(
                                      model[index].quotes![2].percentChange24h);
                              var price = DecimalRounder.removePriceDecimals(
                                  model[index].quotes![2].price);
                              var percentChange =
                                  DecimalRounder.removePercentDecimals(
                                      model[index].quotes![2].percentChange24h);
                              Color percentColor =
                                  DecimalRounder.setPercentChangesColor(
                                      model[index].quotes![2].percentChange24h);
                              Icon percentIcon =
                                  DecimalRounder.setPercentChangesIcon(
                                      model[index].quotes![2].percentChange24h);
                              return SizedBox(
                                height: height * 0.075,
                                child: InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CoinPage(
                                        tokenId: tokenId,
                                        filterColor: filterColor,
                                        price: price,
                                        percentChange: percentChange,
                                        percentColor: percentColor,
                                        percentIcon: percentIcon,
                                        name: model[index].name.toString(),
                                        symbol: model[index].symbol.toString(),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          '${index + 1}',
                                          style: textTheme.bodySmall,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 15),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png',
                                          fadeInDuration:
                                              const Duration(milliseconds: 500),
                                          height: 32,
                                          width: 32,
                                          placeholder: (BuildContext context,
                                                  String url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (BuildContext context,
                                                  String url, dynamic error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              model[index].name.toString(),
                                              style: textTheme.bodySmall,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              model[index].symbol.toString(),
                                              style: textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                            filterColor,
                                            BlendMode.srcATop,
                                          ),
                                          child: SvgPicture.network(
                                              'https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                '\$$price',
                                                style: textTheme.bodySmall,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  percentIcon,
                                                  Text(
                                                    '$percentChange%',
                                                    style: GoogleFonts.ubuntu(
                                                        color: percentColor,
                                                        fontSize: 11),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider();
                            },
                            itemCount: model!.length);

                      case Status.ERROR:
                        return Text(cryptoDataProvider.state.message);

                      default:
                        return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
