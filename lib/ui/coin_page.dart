import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CoinPage extends StatelessWidget {
  const CoinPage({
    super.key,
    required this.tokenId,
    required this.filterColor,
    required this.price,
    required this.percentChange,
    required this.percentColor,
    required this.percentIcon,
    required this.name,
    required this.symbol,
  });

  final int? tokenId;
  final MaterialColor filterColor;
  final String price;
  final String percentChange;
  final Color percentColor;
  final Icon percentIcon;
  final String name;
  final String symbol;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl:
                  'https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png',
              fadeInDuration: const Duration(milliseconds: 500),
              height: 32,
              width: 32,
              placeholder: (BuildContext context, String url) =>
                  const CircularProgressIndicator(),
              errorWidget: (BuildContext context, String url, dynamic error) =>
                  const Icon(Icons.error),
            ),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
            ),
            Text(symbol),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                filterColor,
                BlendMode.srcATop,
              ),
              child: SvgPicture.network(
                  'https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg'),
            ),
            Text(
              '\$$price',
            ),
            percentIcon,
            Text(
              '$percentChange%',
              style: GoogleFonts.ubuntu(color: percentColor, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
