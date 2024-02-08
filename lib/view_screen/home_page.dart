import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/service/api_service.dart';
import 'package:currency_converter/view/components/all_currency_list_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices apiServices = ApiServices();
  String _selectedCurrency='USD';

  Widget _dropDownItem(Country country){
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
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              'Base Currency',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              height: 8,
            ),
            /*Container(

              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: CountryPickerDropdown(
                initialValue: 'us',
                itemBuilder:_dropDownItem ,
                onValuePicked: (Country?country){
                  setState(() {
                    _selectedCurrency = country?.currencyCode??"";
                  });
                },
              ),
            ),*/
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
                        _selectedCurrency = country?.currencyCode??"";
                      });
                    },
                  ),
                ),

              ),
            ),
            Text('All Currency',style: TextStyle(fontSize: 20,color: Colors.white),),
            SizedBox(
              height: 8,
            ),
            FutureBuilder(future: apiServices.getLatest(_selectedCurrency),
                builder: (context,snapshot){
              if(snapshot.hasData){
                List<CurrencyModel>currencyModel = snapshot.data??[];
                return Expanded(child: ListView.builder(
                  itemBuilder: (context,index){
                    return AllCurrencyListItem(currencyModel: currencyModel[index]);
                  },
                  itemCount: currencyModel.length,
                )
                );
              }if(snapshot.hasError){
                return Center(child: Text("Error",style: TextStyle(fontSize: 20,color: Colors.white),),);
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
                }

            )

          ],
        ),
      ),
    );
  }
}
