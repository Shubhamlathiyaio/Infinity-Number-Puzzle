import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_provider/logic.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

void main() {
  runApp(MaterialApp(home: ChangeNotifierProvider(
      create: (_)=>logic(),
      child: Home(),),debugShowCheckedModeBanner: false
    ,
  ));
}
