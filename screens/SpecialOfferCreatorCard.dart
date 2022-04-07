import 'package:film_caffe_aplikacija/Constants/constants.dart';
import 'package:film_caffe_aplikacija/Widgets/drawer.dart';
import 'package:film_caffe_aplikacija/models/SpecialOffer.dart';
import 'package:film_caffe_aplikacija/models/Table.dart';
import 'package:film_caffe_aplikacija/models/event.dart';
import 'package:film_caffe_aplikacija/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class SpecialOfferCreatorCard extends StatefulWidget {
  const SpecialOfferCreatorCard({Key? key}) : super(key: key);

  @override
  _SpecialOfferCreatorCardState createState() => _SpecialOfferCreatorCardState();
}

class _SpecialOfferCreatorCardState extends State<SpecialOfferCreatorCard> {
  String name = "";
  String desc = "";
  final _picker = ImagePicker();
  int requiredAmount=1;
  File? _image = null;
  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                child: InkWell(
                  onTap: () async {
                    XFile? image = await _picker.pickImage(
                        source: ImageSource.gallery);
                    if (image != null)
                      setState(() {
                        _image = File(image!.path);
                      });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: _image == null ? Image.network(
                        "https://via.placeholder.com/350x150"
                    ) : Image.file(_image!,width: 350,height: 350,fit: BoxFit.fitHeight,),
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ), TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                    hintText: "Naziv Akcije"
                ),
                onChanged: (val) {
                  setState(() {
                    name = val;
                    print(name);
                  });
                },
              ), SizedBox(height: 10,),
              TextFormField(
                initialValue: desc,
                decoration: InputDecoration(
                    hintText: "Opis Akcije"
                ),
                onChanged: (val) {
                  desc = val;
                },
                maxLines: 2,
              ),
              RaisedButton(onPressed: () async {
                if(_image!=null && name!="") {
                  String imgURL = await DatabaseService().uploadFile(_image!);
                  SpecialOffer specialOffer = SpecialOffer(
                    imgUrl: imgURL,
                    name: name,
                    desc: desc,
                    requiredAmount: requiredAmount,
                  );
                  String offerId =await DatabaseService().addSpecialOffer(specialOffer);
                  specialOffer.id=offerId;
                  print("Uspesno dodavanje");
                }
              },
                  child:
                  Text("Postavi Akciju")
              )
            ],
          ),
        ),
      );
    }
  }
