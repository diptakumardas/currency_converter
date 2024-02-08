import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

import '../service/api_service.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  TextEditingController _textController = TextEditingController();

  ApiServices apiServices = ApiServices();
  String _selectedBaseCurrency = 'USD';
  String _selectedTargetCurrency = 'BDT';
  String _totalValue = '';

  Widget _dropDownItem(Country country) {
    return Container(
      child: Row(
        children: [
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(
            width: 10,
          ),
          Text("${country.currencyName}")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Base Currency',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height*.08,
              width: MediaQuery.sizeOf(context).width,
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CountryPickerDropdown(
                    initialValue: 'us',
                    itemBuilder:_dropDownItem ,
                    onValuePicked: (Country?country){
                      setState(() {
                        _selectedBaseCurrency = country?.currencyCode??"";
                      });
                    },
                  ),
                ),

              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Target Currency',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),

/////////////////////////2nd picker
            SizedBox(
              height: MediaQuery.sizeOf(context).height*.08,
              width: MediaQuery.sizeOf(context).width,
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CountryPickerDropdown(
                    initialValue: 'BD',
                    itemBuilder:_dropDownItem ,
                    onValuePicked: (Country?country){
                      setState(() {
                        _selectedTargetCurrency = country?.currencyCode??"";
                      });
                    },
                  ),
                ),

              ),
            ),
            ElevatedButton(
                onPressed: () async{
                  if(_textController.text.isNotEmpty){
                    await apiServices.getExchange(_selectedBaseCurrency, _selectedTargetCurrency).then((result) {
                      double value = double.parse(_textController.text);
                      double exchangeRate = double.parse(result![0].value.toString());
                      double total = value * exchangeRate;
                      _totalValue = total.toStringAsFixed(2).toString();
                      setState(() {

                      });
                    });


                  }
                },
                child: Text(
                  "Exchange",
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 15,
            ),
            Text(
              _totalValue+_selectedTargetCurrency,
              style: TextStyle(
                  fontSize: 50, fontWeight: FontWeight.bold, color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
