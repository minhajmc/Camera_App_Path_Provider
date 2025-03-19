
import 'package:camera/camera.dart';
import 'package:cameramain1/home.dart';
import 'package:flutter/material.dart';

List<CameraDescription>availableCamera=[];
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  availableCamera=await availableCameras();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Camera App",   
      home: Home(),
    );
  }
}