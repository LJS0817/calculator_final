import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:calculator_final/models/dummys.dart';
import 'package:calculator_final/models/themeModel.dart';
import 'package:calculator_final/models/oilContainer.dart';

class SoapScreen extends StatefulWidget {
  @override
  _SoapScreen createState() => _SoapScreen();
}

class _SoapScreen extends State<SoapScreen> {

  Future<String?> openDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
        context: context,
        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextField(
                    controller: controller,
                    autocorrect: false,
                    autofocus: false,
                    decoration: const InputDecoration(
                      hintText: "ENTER TITLE",
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  TextField(
                    controller: controller,
                    autocorrect: false,
                    autofocus: false,
                    decoration: const InputDecoration(
                      hintText: "ENTER DETAILS",
                    ),
                  ),
                ],
              ),
            ),
            insetPadding: const EdgeInsets.fromLTRB(0,80,0, 80),
            actions: [
              TextButton(
                child: const Text('추가하기'),
                onPressed: () {
                  Navigator.of(context).pop(controller.text.toString());
                },
              ),
            ],
          );
        }
    );
  }

  void showTabs(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: dialogContent(() { setState(() {}); }),
                insetPadding: const EdgeInsets.fromLTRB(0,80,0, 80),
                actions: [
                  TextButton(
                    child: const Text('확인'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
    );
  }

  Container listViewItem(int idx, String name, Function func) {
    return Container(
        height: 53,
        decoration: BoxDecoration(
          color: themeData.textColor,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: themeData.themeColor.withAlpha(100),
            highlightColor: themeData.themeColor.withAlpha(100),
            focusColor: themeData.themeColor.withAlpha(100),
            onTap: () {
              func();
              setState(() {
                if(oilData.containsKey(idx)) {
                  oilData.remove(idx);
                  containers[curIndex - 1].remove(idx);
                } else {
                  oilData[idx] = true;
                  containers[curIndex - 1][idx] = oilContainer(idx, 0, () {setState(() {});});
                  scrollToBottom();
                }
              });
            },
            child: Row(
              children: [
                Icon((oilData[idx] != null && oilData[idx]) ? Icons.water_drop : Icons.water_drop_outlined, color: themeData.themeColor,),
                const Padding(padding: EdgeInsets.only(right: 10),),
                Flexible(
                  child: Text(
                    name,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      color: themeData.themeColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Container dialogContent(Function func) {
    return Container(
        height: size.height * 0.7,
        width: size.width * 0.8,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: oils.length,
                itemBuilder: (BuildContext context, int index) {
                  return listViewItem(index, oils[index].getName(), func);
                },
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40)),
          ],
        )
    );
  }

  @override
  void initState() {
    super.initState();
    date = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day < 10 ? "0" + DateTime.now().day.toString() : DateTime.now().day }";
    log(Platform.localeName.toString());
    isKor = Platform.localeName.toString().contains("ko") ? true : false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
                height: MediaQuery.of(context).padding.top * 2,
                width: size.width,
                decoration: BoxDecoration(
                  color: themeData.themeColor,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 8,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 26,
                          color: themeData.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: size.height * 0.2,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                        decoration: BoxDecoration(
                            color: themeData.themeColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36),
                            )
                        ),
                      ),

                      Positioned(
                        top: size.height * -0.003,
                        left: size.width * 0.3,
                        right: size.width * 0.1,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.drive_file_rename_outline,
                              color: themeData.textColor,
                              size: 20,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            Expanded(
                              child: TextField(
                                enabled: false,
                                controller: nameController,
                                style: const TextStyle(
                                  color: themeData.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                  hintText: textData().getName(),
                                  border: InputBorder.none,
                                  hintStyle: const TextStyle(
                                    color: themeData.textColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        top: size.height * 0.061,
                        left: size.width * 0.3,
                        right: size.width * 0.1,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: themeData.textColor,
                              size: 20,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            Text(
                              "${textData().getDate()}  :  $date",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: themeData.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        top: size.height * 0.106,
                        left: size.width * 0.3,
                        right: size.width * 0.1,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.label,
                              color: themeData.textColor,
                              size: 20,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            Text(
                              "${textData().getType()}  :  ${getType_toString()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: themeData.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                          left: 16,
                          top: 10,
                          child: Column(
                            children: [
                              Icon(
                                Icons.whatshot,
                                color: themeData.textColor,
                                size: size.height * 0.11,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.horizontal_distribute,
                                    color: themeData.textColor,
                                    size: 22,
                                  ),
                                  const Padding(padding: EdgeInsets.only(right: 7)),
                                  Text(
                                    total_weight.floor().toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        color: themeData.textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                    ],
                  )
              ),

              ////////////////////////////////////////////
              Visibility(
                key: UniqueKey(),
                visible: curIndex == 0,
                child: Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      titleForm(textData().getRecipeTitle(), true),
                      textFieldForm(nameController, textData().getName(), false),
                      titleForm(textData().getTypeTitle()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          typeButton("C.P", TYPE.E_COLD, () { setState(() { themeData.changeTheme(TYPE.E_COLD); }); }),
                          Padding(padding: EdgeInsets.only(right: isSoap ?  60 : 10)),
                          typeButton("H.P", TYPE.E_HOT, () { setState(() { themeData.changeTheme(TYPE.E_HOT); }); }),
                          Padding(padding: EdgeInsets.only(right: isSoap ?  60 : 10)),
                          typeButton(textData().getTypes(TYPE.E_LENGTH.index), TYPE.E_PASTE, () { setState(() { themeData.changeTheme(TYPE.E_PASTE); }); }),
                          Padding(padding: EdgeInsets.only(right: isSoap ? 0 : 10)),
                          Visibility(
                            visible: !isSoap,
                            child: typeButton("물비누", TYPE.E_PASTE, () { setState(() { themeData.changeTheme(TYPE.E_COLD); }); }),
                          ),
                        ],
                      ),

                      titleForm(textData().getValueTitle()),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.only(left: 8)),
                          Expanded(child: textFieldForm(nameController, textData().getLyePurity(), true),),
                          Expanded(child: textFieldForm(nameController, textData().getLyeCount(), true),),
                          Visibility(
                            visible: themeData.type == TYPE.E_COLD,
                            child: Expanded(child: textFieldForm(nameController, textData().getWater(), true),),
                          ),
                          const Padding(padding: EdgeInsets.only(right: 8)),
                        ],
                      ),

                      Visibility(
                        visible: themeData.type == TYPE.E_HOT,
                        child: Column(
                          children: [
                            const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(padding: EdgeInsets.only(left: 8)),
                                Expanded(child: textFieldForm(nameController, textData().getPureSoap(), true),),
                                Expanded(child: textFieldForm(nameController, textData().getSolvent(), true),),
                                Expanded(child: textFieldForm(nameController, textData().getSugar(), true),),
                                const Padding(padding: EdgeInsets.only(right: 8)),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(padding: EdgeInsets.only(left: 8)),
                                Expanded(child: textFieldForm(nameController, textData().getGlycerine(), true),),
                                Expanded(child: textFieldForm(nameController, textData().getEthanol(), true),),
                                const Padding(padding: EdgeInsets.only(right: 8)),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(bottom: 20)),
                    ],
                  ),
                ),
              ),
              ////////////////////////////////////////////

              ////////////////////////////////////////////
              Visibility(
                key: UniqueKey(),
                visible: curIndex == 1,
                child: Expanded(
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Expanded(
                        child: ListView(
                          controller: listController,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: containers[0].values.toList(),
                        ),
                      ),
                      Visibility(
                        visible: containers[0].length == 0,
                        child: Column(
                            children: [
                              Text(
                                textData().getOilGuide(),
                                style: TextStyle(
                                  color: themeData.themeColor.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 25,
                                color: themeData.themeColor.withOpacity(0.7),
                              ),
                            ]
                        ),
                      ),
                      // buttonForm("Add Oil", size.width, themeData.textColor, themeData.themeColor, Icons.add,
                      //         () { setState(()=> { showTabs(context) }); }, false, 18, 10)
                    ],
                  ),
                ),
              ),
              ////////////////////////////////////////////

              ////////////////////////////////////////////
              Visibility(
                visible: curIndex == 2,
                child: Expanded(
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Expanded(
                        child: ListView(
                            controller: listController,
                            padding: EdgeInsets.zero,
                            children: containers[1].values.toList()
                        ),
                      ),
                      Visibility(
                        visible: containers[1].length == 0,
                        child: Column(
                            children: [
                              Text(
                                textData().getSuperGuide(),
                                style: TextStyle(
                                  color: themeData.themeColor.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 25,
                                color: themeData.themeColor.withOpacity(0.7),
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ////////////////////////////////////////////

              ////////////////////////////////////////////
              Visibility(
                visible: curIndex == 3,
                child: Expanded(
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Expanded(
                        child: ListView(
                          controller: listController,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: containers[2].values.toList(),
                        ),
                      ),
                      Visibility(
                        visible: containers[2].length == 0,
                        child: Column(
                            children: [
                              Text(
                                textData().getAddGuide(),
                                style: TextStyle(
                                  color: themeData.themeColor.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 25,
                                color: themeData.themeColor.withOpacity(0.7),
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ////////////////////////////////////////////

              ////////////////////////////////////////////
              Visibility(
                visible: curIndex == 4,
                child: Expanded(
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Expanded(
                        child: ListView(
                          controller: listController,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: containers[3].values.toList(),
                        ),
                      ),
                      Visibility(
                        visible: containers[3].length == 0,
                        child: Column(
                            children: [
                              Text(
                                textData().getMemoGuide(),
                                style: TextStyle(
                                  color: themeData.themeColor.withOpacity(0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 25,
                                color: themeData.themeColor.withOpacity(0.7),
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ////////////////////////////////////////////

              ////////////////////////////////////////////
              Visibility(
                visible: curIndex == 5,
                child: Expanded(
                  child: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Expanded(
                        child: ListView(
                          controller: listController,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          children: containers[3].values.toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ////////////////////////////////////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 64,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            foregroundColor: themeData.themeColor,
                          ),
                          onPressed: () {
                            if(curIndex == 0) return;
                            setState(()=> {
                              curIndex -= 1
                            });
                          },
                          child: Row(
                            mainAxisAlignment: curIndex > 0 && curIndex < soap_lastPage ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.chevron_left, color: themeData.themeColor,),
                              Visibility(
                                visible: curIndex == 0 || curIndex == soap_lastPage,
                                child: Text(
                                  textData().getPrevBtn(),
                                  style: TextStyle(
                                    color: themeData.themeColor,
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),
                  Visibility(
                    visible: curIndex > 0 && curIndex < soap_lastPage,
                    child: Expanded(
                      child: SizedBox(
                        height: 64,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            foregroundColor: themeData.textColor,
                            backgroundColor: themeData.themeColor,
                          ),
                          onPressed: () {
                            setState(() {
                              if(curIndex < soap_lastPage - 1) showTabs(context);
                              else openDialog(context);
                            });
                          },
                          child: Icon(Icons.add_circle_outline, color: themeData.textColor,),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 64,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                            color: curIndex > 0 && curIndex < soap_lastPage ? themeData.textColor : themeData.themeColor
                        ),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              foregroundColor: themeData.themeColor
                            ),
                            onPressed: () {
                              setState(()=> {
                                if(curIndex < soap_lastPage) curIndex += 1
                                // else
                              });
                            },
                            child: Row(
                              mainAxisAlignment: curIndex > 0 && curIndex < soap_lastPage ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                              children: [
                                Visibility(
                                  visible: curIndex == 0 || curIndex == soap_lastPage,
                                  child: Text(
                                    textData().getNextBtn(curIndex == soap_lastPage),
                                    style: TextStyle(
                                      color: curIndex > 0 && curIndex < soap_lastPage ? themeData.themeColor : themeData.textColor,
                                    ),
                                  ),
                                ),
                                Icon(
                                  curIndex == soap_lastPage ? Icons.save : (curIndex == soap_lastPage - 1 ? Icons.last_page_outlined : Icons.chevron_right),
                                  color: curIndex > 0 && curIndex < soap_lastPage ? themeData.themeColor : themeData.textColor,),
                              ],
                            )
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ]
        ),
      ),
    );
  }
}