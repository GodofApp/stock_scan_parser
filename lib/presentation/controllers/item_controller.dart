import 'package:get/get.dart';
import 'package:stock_scan_parser/core/models/stock_model.dart';
import 'package:stock_scan_parser/data/repositories/items_repository.dart';

class ItemController extends GetxController{

  List<StockModel> moduleItemsList = List<StockModel>.empty(growable: true).obs;

  var isLoadingData = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getStockModel();
  }


  Future<List<StockModel>> getStockModel() async {
    try {
      isLoadingData(true);
      // showLoader(context);
      var stockData = await ItemsRepository.getStockData("http://coding-assignment.bombayrunning.com/data.json");
      if (stockData != null) {
        // Loader.hide();
        moduleItemsList.clear();
        moduleItemsList = stockData;
      }
    } finally {
      // Loader.hide();
      isLoadingData(false);
    }
    return moduleItemsList;
  }

}