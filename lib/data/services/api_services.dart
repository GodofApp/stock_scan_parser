import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../core/errors/exceptions.dart';

class ApiServices{

  Future<dynamic> get(String url) async {
    // loader ? showLoader(context) : Container();

    var responseJson;
    try {

      var response =
      await http.get(Uri.parse(url));
      responseJson = _response(response);

      if (!kReleaseMode) {
        log(url);
      }
    } on TimeoutException catch (e) {
      log('Timeout Error: $e');
    } on SocketException catch (e) {
      log('Socket Error: $e');
    } on Error catch (e) {
      log('Error: $e');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    // Loader.hide();

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
    }
  }
}