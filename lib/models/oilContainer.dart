import 'dart:developer';

import 'package:calculator_final/models/Oil.dart';
import 'package:flutter/material.dart';
import 'dummys.dart';
import 'themeModel.dart';

enum ORDER {
  E_ONLY,
  E_FIRST,
  E_MIDDLE,
  E_LAST
}

class oilContainer extends StatelessWidget {
  double weight = 0;
  ORDER order = ORDER.E_MIDDLE;
  int index = -1;

  TextEditingController controller = TextEditingController();
  late Oil data;
  late Function func;

  oilContainer(int idx, double w, Function f, {super.key}) {
    weight = w;
    index = idx;
    data = oils[index];
    func = f;
  }

  Future<String?> openDialog(BuildContext context) {
    return showDialog<String>(
        context: context,
        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                data.getName()
            ),
            content: TextField(
              controller: controller,
              autocorrect: false,
              autofocus: false,
              decoration: const InputDecoration(
                hintText: "ENTER VALUE",
              ),
            ),
            insetPadding: const EdgeInsets.fromLTRB(0,80,0, 80),
            actions: [
              TextButton(
                child: const Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop(controller.text.toString());
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: const EdgeInsets.only(right: 10, left: 10),
        decoration: BoxDecoration(
          color: themeData.themeColor,
          borderRadius: order == ORDER.E_LAST ?
          BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) :
          (order == ORDER.E_FIRST ? BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) :
          (order == ORDER.E_ONLY ? BorderRadius.circular(10) :
          BorderRadius.circular(0))),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 20,
                color: Colors.black.withOpacity(0.13)
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: themeData.textColor.withOpacity(0.3),
            splashColor: themeData.textColor.withOpacity(0.3),
            child: Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 15)),
                const Icon(Icons.water_drop, size: 20, color: themeData.textColor,),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Text(data.getName(), style: const TextStyle(color: themeData.textColor, fontWeight: FontWeight.bold),),
                const Spacer(),
                Text("${weight}g", style: const TextStyle(color: themeData.textColor, fontWeight: FontWeight.bold),),
                const Padding(padding: EdgeInsets.only(right: 15.0)),
              ],
            ),
            onTap: () async {
              openDialog(context).then((value) => {
                total_weight -= weight,
                weight = double.tryParse(value.toString()) ?? 0,
                total_weight += weight,
                func(),
              });
            },
            onLongPress: () {
              oilData.remove(index);
              containers[curIndex - 1].remove(index);
              if(containers[curIndex - 1].length == 1) {
                containers[curIndex - 1].values.first.order = ORDER.E_ONLY;
              } else if(containers[curIndex - 1].length > 1) {
                containers[curIndex - 1].values.first.order = ORDER.E_FIRST;
                containers[curIndex - 1].values.last.order = ORDER.E_LAST;
              }
              func();
            },
          ),
        )
    );
  }
}