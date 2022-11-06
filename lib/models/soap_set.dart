import 'dart:developer';

import 'package:calculator_final/models/unit.dart';

class SoapSet extends Unit {
  late int lye_count;
  late int lye_purity;
  late String water_text;

  late List<String> adds;
  late List<String> oils;

  late int pure;
  late int solvent;
  late int ethanol;
  late int sugar;

  SoapSet({
    required name,
    required date,
    required type,
    required path,
 }) : super(name: name, date: date,type: type, path: path);

  void setOils(String lists) {
    oils = lists.split(',');
  }

  void setSuper(String lists) {
    adds = lists.split(',');
  }

  static SoapSet parse(String s, String p)
  {
    late SoapSet soap;
    try {
      List<String> str = s.split(',');

      soap = SoapSet(name: str[0], date: str[1], type: str[2], path: p);
      soap.setOils(s.split('\n')[1]);
      soap.setSuper(s.split('\n')[2]);
    } catch(e) {
      log(e.toString());
    }
    return soap;
  }
}