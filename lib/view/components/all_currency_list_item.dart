import 'package:currency_converter/models/currency_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllCurrencyListItem extends StatefulWidget {
  final CurrencyModel currencyModel;
  const AllCurrencyListItem({super.key, required this.currencyModel});

  @override
  State<AllCurrencyListItem> createState() => _AllCurrencyListItemState();
}

class _AllCurrencyListItemState extends State<AllCurrencyListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(88),
        borderRadius: BorderRadius.circular(10)
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.currencyModel.code.toString(),
            style: TextStyle(fontSize: 17, color: CupertinoColors.white),
          ),
          Text(
            widget.currencyModel.value?.toStringAsFixed(2)??"",
            style: TextStyle(fontSize: 17, color: CupertinoColors.white),
          ),

        ],
      ),
    );
  }
}
