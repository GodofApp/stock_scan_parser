

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_scan_parser/core/models/stock_model.dart';
import 'package:stock_scan_parser/presentation/controllers/item_controller.dart';

import 'expanded_list.dart';

class AppMain extends StatelessWidget {

  ItemController itemController = Get.put(ItemController());

  AppMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Stock Parser"),
        ),
        body: Obx(() =>
          itemController.isLoadingData.value ?
          const Center(child: CircularProgressIndicator()):
          ListView.builder(
          itemCount: itemController.moduleItemsList.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            StockModel data = itemController.moduleItemsList.elementAt(index);
            return ExpandedList(stockModelData: data,);
          },
        )
        ),
    );
  }
}
