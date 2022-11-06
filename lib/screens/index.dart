import 'dart:developer';

import 'package:calculator_final/models/Oil.dart';
import 'package:calculator_final/models/dummys.dart';
import 'package:flutter/material.dart';
import 'package:calculator_final/tabs/beauty.dart';
import 'package:calculator_final/tabs/oil.dart';
import 'package:calculator_final/tabs/settings.dart';
import 'package:calculator_final/tabs/soap.dart';
import 'package:calculator_final/models/themeModel.dart';


class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

void loadAsset(BuildContext context) async {
  String s = await DefaultAssetBundle.of(context).loadString('assets/data.csv');
  List<String> list = s.split('\n');
  List<String> data = [];
  Oil? oil;
  for(int i = 0; i < list.length; i++) {
    try{
      data = list[i].split(',');
      oil = Oil(index: int.parse(data[0]), korean: data[1], english: data[2], NaOH: double.parse(data[3]),
          KOH: double.parse(data[4]), fat: List.generate(FAT_TYPE.LENGTH.index,
                  (index) => double.tryParse(data[index + 5]) ?? 0.0));
      list = s.split('\n');
      oils.add(oil);
    } catch(ex) {
      log("ERROR : $ex");
    }
  }
  //index,korean,english,NaOH,KOH,Lauric,Myristic,
  //Palmitic,Stearic,Palmitoleic,Ricinoleic,Oleic,Linoleic,Linolenic
}

class _IndexScreenState extends State<IndexScreen> {
  int _curIndex = 0;
  final List<Widget> _tabs = [
    SoapTab(),
    Beautytab(),
    Oiltab(),
    ConfigTab(),
  ];
  @override
  void initState() {
    super.initState();
    loadAsset(context);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.themeColor,
        title: Text(_curIndex == 0 ? "Calculator" : (_curIndex == 1) ? "Beauty" :
        (_curIndex == 2) ? "Oil" : "Settings"),
        actions: [
          IconButton(
              onPressed: () => {
                Navigator.pushNamed(context, '/create/soap')
              },
              icon: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: _curIndex,
        onTap: (index) {
          setState(() {
            _curIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.soap), label: '비누'),
          BottomNavigationBarItem(icon: Icon(Icons.batch_prediction), label: '화장품 '),
          BottomNavigationBarItem(icon: Icon(Icons.oil_barrel), label: '오일 '),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정 '),
        ],
      ),
      body: _tabs[_curIndex],
    );
  }
}