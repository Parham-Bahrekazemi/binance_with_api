import 'package:binance/network/api_provider.dart';
import 'package:binance/network/response_model.dart';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';

import '../models/CryptoModel/AllCryptoModel.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;

  late ResponseModel state;
  Response? response;
  getTopMarketCapData() async {
    state = ResponseModel.loading('is Loading...');

    try {
      response = await apiProvider.getTopMarketCapData();

      if (response!.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response!.data);

        state = ResponseModel.complete(dataFuture);
      } else {
        state = ResponseModel.error('Somthing Wrong...');
      }

      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('please check your connection !');

      notifyListeners();
    }
  }

  getTopGainerData() async {
    state = ResponseModel.loading('is Loading...');

    try {
      response = await apiProvider.getTopGainerData();

      if (response!.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response!.data);

        state = ResponseModel.complete(dataFuture);
      } else {
        state = ResponseModel.error('Somthing Wrong...');
      }

      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('please check your connection !');

      notifyListeners();
    }
  }

  getTopLoserspData() async {
    state = ResponseModel.loading('is Loading...');

    try {
      response = await apiProvider.getTopLosersData();

      if (response!.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response!.data);

        state = ResponseModel.complete(dataFuture);
      } else {
        state = ResponseModel.error('Somthing Wrong...');
      }

      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('please check your connection !');
      notifyListeners();
    }
  }
}
