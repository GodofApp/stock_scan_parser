import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_scan_parser/core/models/stock_model.dart';
import 'package:stock_scan_parser/data/services/api_services.dart';

class ItemsRepository{
  static var client = http.Client();

  static var apiServices = ApiServices();

  static Future<List<StockModel>> getStockData(String url) async {
    var response = await apiServices.get(url);
    if (response is List<dynamic>) {
      List<StockModel> stockData = response.map((item) => StockModel.fromJson(item)).toList();
      return stockData;
    } else {
      throw Exception('Failed to load stock data');
    }
  }
}