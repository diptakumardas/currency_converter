import 'dart:convert';

import 'package:currency_converter/constants/constants.dart';
import 'package:currency_converter/models/currency_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class ApiServices{
  Future<List<CurrencyModel>?> getLatest (String baseCurrency) async {
    List<CurrencyModel> currencyModelList=[];

    String url = '${baseUrl}apikey=$apiKey&base_currency=$baseCurrency';
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        Map<String,dynamic>json= jsonDecode(response.body);
        Map<String,dynamic>body=json['data'];
        body.forEach((key, value) {
          CurrencyModel currencyModel = CurrencyModel.fromJson(value);
          currencyModelList.add(currencyModel);
        });
       return currencyModelList;
      }else {return[];}

    }
    catch(e){throw e.toString();}
  }

  Future<List<CurrencyModel>?> getExchange (String baseCurrency,String targetCurrency) async {
    List<CurrencyModel> currencyModelList=[];

    String url = '${baseUrl}apikey=$apiKey&base_currency=$baseCurrency&currencies=$targetCurrency';
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode==200){
        Map<String,dynamic>json= jsonDecode(response.body);
        Map<String,dynamic>body=json['data'];

        body.forEach((key, value) {
          CurrencyModel currencyModel = CurrencyModel.fromJson(value);
          //print(currencyModel.value);
          currencyModelList.add(currencyModel);
        });
        return currencyModelList;
      }else {return[];}

    }
    catch(e){throw e.toString();}
  }


}