import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_scan_parser/core/models/stock_model.dart';

import '../../core/constants/value_types.dart';
import '../widgets/clickable_text.dart';

class ExpandedList extends StatelessWidget {
  final StockModel stockModelData;

  var expandFlag = false.obs;

  ExpandedList({super.key, required this.stockModelData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          expandFlag.value = !expandFlag.value;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.candlestick_chart),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stockModelData.name ?? "",
                            style: const TextStyle(
                              height: 2,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              decoration: TextDecoration.underline
                            ),
                          ),
                          Text(
                            stockModelData.tag ?? "",
                            style: TextStyle(
                                height: 1,
                                fontWeight: FontWeight.normal,
                                fontSize: 10,
                                decoration: TextDecoration.underline,
                                color: stockModelData.color == "green"
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      )
                    ],
                  ),
                  Obx(() => Icon(
                        expandFlag.value
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_outlined,
                        color: Colors.black,
                        size: 20,
                      ))
                ],
              ),
            ),
            Obx(() => expandFlag.value && stockModelData.criteria != null
                ? ListView.separated(
                    shrinkWrap: true,
                    itemCount: stockModelData.criteria != null
                        ? stockModelData.criteria!.length
                        : 0,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (stockModelData.criteria != null) {
                        Criterion data =
                            stockModelData.criteria!.elementAt(index);

                        String decodedText = utf8.decode(data.text!.runes.toList());

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: data.variable == null ?
                          Text(
                            decodedText ?? "",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal),
                          ) :
                          ClickableText(
                            text: decodedText ?? "",
                            variables: data.variable!,
                            onTap: (value) {
                              showPopupConditions(context, data, value);
                            },
                          ),
                        );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  )
                : Container()),
          ],
        ),
      ),
    );
  }

  showPopupConditions(BuildContext context,Criterion data,String value){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (data.variable!.containsKey(value)) {
          if (data.variable![value]['type'] == ValueTypes.typeValue) {
            RxString selectedItem = data.variable![value]['values'][0].toString().obs;
            return AlertDialog(
              title: const Text('Select a value'),
              content: Obx(() =>
                  DropdownButton(
                    value: selectedItem.value,
                    onChanged: (value) {
                      if(value != null){
                        selectedItem.value = value.toString();
                      }
                    },
                    items: (data.variable![value]['values'] as List<dynamic>)
                        .map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  )
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    // Add your OK button logic here
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          }
          else if (data.variable![value]['type'] == ValueTypes.typeIndicator) {
            return AlertDialog(
              title: Text(data.variable![value]['study_type'].toString().toUpperCase()),
              content: Container(
                width: Get.width,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(data.variable![value]['parameter_name'].toString().toUpperCase()),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey, // Custom background color
                          borderRadius: BorderRadius.circular(8.0), // Optional: add border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextField(
                            controller: TextEditingController(text: data.variable![value]['default_value'].toString()),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                            ),

                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    // Add your OK button logic here
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          }
        }
        return const AlertDialog(
          title: Text('Error'),
          content: Text('Key not found in variable'),
        );
      },
    );
  }
}
