import 'dart:developer';

import 'package:calculator_final/models/unit.dart';
import 'package:calculator_final/screens/create_soap.dart';
import 'package:flutter/material.dart';
import 'package:calculator_final/models/Oil.dart';
import 'themeModel.dart';

class Name {
  String kor = "";
  String eng = "";
  Name({
    required this.kor,
    required this.eng
  });

  String Get(bool ko) { return ko ? kor : eng; }
}

class textData {
  static bool isKor = false;
  final Name recipeName = Name(kor: "레시피 이름", eng: "Recipe Name");

  final Name date  = Name(kor: "날짜", eng: "Date");

  final Name type = Name(kor: "종류", eng: "Type");

  final List<Name> types = [
    Name(kor: "C.P 고형비누", eng: "Cold Process"),
    Name(kor: "H.P 고형비누", eng: "Hot Process"),
    Name(kor: "연비누", eng: "Soap Paste"),
    Name(kor: "연비누", eng: "Paste"),
  ];

  final Name recipeTitle = Name(kor: "이름을 입력하세요", eng: "ENTER TITLE");
  final Name typeTitle = Name(kor: "종류를 선택하세요", eng: "SELECT TYPE");
  final Name valueTitle = Name(kor: "값을 입력하세요", eng: "ENTER VALUE");

  final Name lyeP = Name(kor: "Lye 순도", eng: "Lye Purity");
  final Name lyeC = Name(kor: "희망 Lye", eng: "Lye Count");
  final Name water = Name(kor: "정제수", eng: "Water");

  final Name pure = Name(kor: "순비누", eng: "Pure Soap");
  final Name solvent = Name(kor: "용제", eng: "Solvent");
  final Name sugar = Name(kor: "설탕", eng: "Sugar");
  final Name gly = Name(kor: "글리세린", eng: "Glycerine");
  final Name ethanol = Name(kor: "에탄올", eng: "Ethanol");

  final Name oilGuide = Name(kor: "오일 추가하기", eng: "Add Oil");
  final Name superGuide = Name(kor: "슈퍼팻 추가하기", eng: "Add Super Fat");
  final Name addGuide = Name(kor: "첨가물 추가하기", eng: "Add Additive");
  final Name memoGuide = Name(kor: "메모 추가하기", eng: "Add Memo");

  final Name prevBtn = Name(kor: "이전", eng: "Previous");
  final Name nextBtn = Name(kor: "다음", eng: "Next");
  final Name saveBtn = Name(kor: "저장하기", eng: "Save");


  String getName() { return recipeName.Get(isKor); }
  String getDate() { return date.Get(isKor); }
  String getType() { return type.Get(isKor); }

  String getTypes(int idx) { return types[idx].Get(isKor); }

  String getRecipeTitle() { return recipeTitle.Get(isKor); }
  String getTypeTitle() { return typeTitle.Get(isKor); }
  String getValueTitle() { return valueTitle.Get(isKor); }

  String getLyePurity() { return lyeP.Get(isKor); }
  String getLyeCount() { return lyeC.Get(isKor); }
  String getWater() { return water.Get(isKor); }

  String getPureSoap() { return pure.Get(isKor); }
  String getSolvent() { return solvent.Get(isKor); }
  String getSugar() { return sugar.Get(isKor); }
  String getGlycerine() { return gly.Get(isKor); }
  String getEthanol() { return ethanol.Get(isKor); }

  String getOilGuide() { return oilGuide.Get(isKor); }
  String getSuperGuide() { return superGuide.Get(isKor); }
  String getAddGuide() { return addGuide.Get(isKor); }
  String getMemoGuide() { return memoGuide.Get(isKor); }

  String getPrevBtn() { return prevBtn.Get(isKor); }
  String getNextBtn(bool isLast) { return isLast ? saveBtn.Get(isKor) : nextBtn.Get(isKor); }

}

late String name;
const double dotSize = 13;
const double space = 10;
bool isKor = false;

late Size size;

List<Oil> oils = [];
List<Map<int, Widget>> containers = [ <int, Widget>{}, <int, Widget>{}, <int, Widget>{}, <int, Widget>{} ];
Map oilData = {};
final TextEditingController nameController = TextEditingController();
final TextEditingController LyePurityController = TextEditingController();
final TextEditingController LyeCountController = TextEditingController();
final TextEditingController WaterController = TextEditingController();
final TextEditingController SugarController = TextEditingController();

final ScrollController listController = ScrollController();

bool isSoap = true;
double total_weight = 0;
int curIndex = 0;
String date = "";
final int soap_lastPage = 5;

Container typeButton(String txt, TYPE t, Function func) {
  return Container(
    width: 85,
    height: 85,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      boxShadow: [
        BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 20,
            color: Colors.black.withOpacity(0.13)
        )
      ],
    ),
    child: OutlinedButton(
      onPressed: () {
        func();
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: themeData.type == t ? themeData.textColor : themeData.themeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: themeData.type == t ? themeData.themeColor : themeData.textColor,
      ),
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: themeData.type == t ? themeData.textColor : themeData.themeColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    ),
  );
}

String getType_toString() {
  return textData().getTypes(themeData.type.index);
}

Container titleForm(String s, [bool isFirst = false]) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: (isFirst ? 20 : 30), bottom: 15),
    child: Text(
      s,
      style: TextStyle(
        color: themeData.themeColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

AppBar appBar() {
  return AppBar(
    excludeHeaderSemantics: true,
    backgroundColor: themeData.themeColor,
    elevation: 0,
  );
}

Container textFieldForm(TextEditingController c, String txt, bool isSmall) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(left: 20, right: 20),
    margin: EdgeInsets.symmetric(horizontal: (isSmall ? 8.0 :  20.0), vertical: 0.0),
    height: 64,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      boxShadow: [
        BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 20,
            color: Colors.black.withOpacity(0.13)
        )
      ],
    ),
    child: TextField(
      cursorColor: themeData.themeColor,
      controller: c,
      autocorrect: false,
      keyboardType: isSmall ? TextInputType.number : TextInputType.text,
      style: TextStyle(
        color: themeData.themeColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      decoration: !isSmall ?
      InputDecoration(
        hintText: txt,
        hintStyle: TextStyle(
          color: themeData.themeColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ) :
      InputDecoration(
        labelText: txt,
        labelStyle: TextStyle(
          color: themeData.themeColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );
}

void scrollToBottom() {
  listController.animateTo(
    listController.position.maxScrollExtent,
    duration: const Duration(seconds: 1),
    curve: Curves.fastOutSlowIn,
  );
}
Container buttonForm(String txt, double s, Color forward, Color back, IconData i, Function func, [bool Icon_Right = false, double hor = 0.0, double ver = 0.0]) {
  return Container(
    width: s,
    height: 50,
    margin: EdgeInsets.symmetric(vertical: ver, horizontal: hor),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
            offset: const Offset(0, 10),
            blurRadius: 20,
            color: Colors.black.withOpacity(0.13)
        )
      ],
    ),
    child: OutlinedButton(
      onPressed: () {
        func();
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: forward,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: back,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon_Right ? Text(
            txt,
            style: TextStyle(
              color: forward,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ) : Icon(i, color: forward,),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 20.0)),
          Icon_Right ? Icon(i, color: forward,) : Text(
            txt,
            style: TextStyle(
              color: forward,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
