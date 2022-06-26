import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';


class HomeScreen extends StatefulWidget {
  @override
  homeScreen createState() => homeScreen();
}

class homeScreen extends State<HomeScreen> {
  String dropdownValue = 'Di';
  TextEditingController linkundangan = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController lokasi = TextEditingController();
  String end = "Copy Link";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  generetelink(){
    end = "https://mumu.com/${linkundangan.text}to+${nama.text}+$dropdownValue+${lokasi.text}";
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    var isMobile = MediaQuery.of(context).size.width > 750;
    var isMobile2 = MediaQuery.of(context).size.width;
    bool isWebah = UniversalPlatform.isWeb;
    print("is$isMobile2 ${UniversalPlatform.isWeb}");
    // TODO: implement build
    return Scaffold(
      body: isWebah && isMobile ? Row(
        children: [
          Expanded(
            child: leftSide(),
          ),
          Expanded(
            child:
            rightSide(),
          )
        ],
      ) : SingleChildScrollView(
        child: Column(
          children: [
            leftSide(),
            rightSide(),
          ],
        ),
      ),
    );
  }

  Widget leftSide(){
    return Column(
      children: [
        DefaultText(
          margin: const EdgeInsets.only(top: 20),
          alignmentGeometry: Alignment.center,
          textdata: "MUMU minta ",
        ),
        DefaultText(
            alignmentGeometry: Alignment.center,
            textdata: "hahaha")
      ],
    );
  }

  Widget rightSide(){
    return Column(
      children: [
        DefaultTextfield(
          textEditingController: linkundangan,
          s: (s){
            generetelink();
          },
          title: "link Undangan",
        ),
        DefaultTextfield(
          textEditingController: nama,
          s: (s){
            generetelink();
          },
          title: "nama",
        ),
        DefaultText(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            alignmentGeometry: Alignment.centerLeft,
            textdata: "Keterangan Di/Dari/Asal"),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(30)
          ),
          child: DropdownButton<String>(
            value: dropdownValue,
            alignment: Alignment.centerLeft,
            icon: const Icon(Icons.keyboard_arrow_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 0,
              color: Colors.grey.shade300,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                generetelink();
              });
            },
            items: <String>['Di', 'Dari', 'Asal']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        DefaultTextfield(
            tutup: true,
            textEditingController: lokasi,
            s: (s){
              generetelink();
            },
            title: "lokasi"),


        DefaultText(
            alignmentGeometry: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
            textdata: "Copy Url"),

        DefaultText(textdata: end,
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          alignmentGeometry: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          borderRadius: BorderRadius.circular(30),
          colors: Colors.grey.shade300,),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 60,
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  final data = ClipboardData(text: end);
                  Clipboard.setData(data);
                },
                child: DefaultText(
                  // margin: const EdgeInsets.only(right: 8),
                  alignmentGeometry: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  borderRadius: BorderRadius.circular(30),
                  colors: Colors.blue,
                  textdata: "Copy Link",
                  textColors: Colors.white,
                ),
              ),
              DefaultText(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                alignmentGeometry: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                borderRadius: BorderRadius.circular(30),
                colors: Colors.blue,
                textdata: "View Link",
                textColors: Colors.white,
              ),
              DefaultText(
                alignmentGeometry: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                borderRadius: BorderRadius.circular(30),
                colors: Colors.blue,
                textdata: "Share to Whatsapp",
                textColors: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DefaultText extends StatelessWidget {
  late String textdata;
  late EdgeInsetsGeometry? margin = const EdgeInsets.all(8);
  late EdgeInsetsGeometry? padding = const EdgeInsets.all(8);
  late BorderRadiusGeometry? borderRadius;
  late AlignmentGeometry? alignmentGeometry;
  late Color? colors;
  late Color? textColors;

  DefaultText({Key? key,
    required this.textdata,
    this.margin,
    this.padding,
    this.alignmentGeometry,
    this.borderRadius,
    this.textColors,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: margin,
      padding: padding,
      alignment: alignmentGeometry,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: borderRadius
      ),
      child: Text(
        textdata,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: textColors
        ),
      ),
    );
  }
}

class DefaultTextfield extends StatelessWidget {

  TextEditingController? textEditingController;
  EdgeInsetsGeometry margin = const EdgeInsets.all(8);
  EdgeInsetsGeometry padding = const EdgeInsets.all(8);
  Function(String)? s;
  bool? tutup;
  late String title;

  DefaultTextfield({Key? key,
    required this.title,
    this.textEditingController,
    this.s,
    this.tutup
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: padding,
      margin: margin,
      child: Column(
        children: [
          tutup == null ? DefaultText(
              alignmentGeometry: Alignment.centerLeft,
              textdata: title) : Container(),
          Container(
            margin: tutup == null ? const EdgeInsets.only(top: 8) : null,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.shade300
            ),
            child: TextFormField(
              controller: textEditingController,
              onChanged: s,
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
