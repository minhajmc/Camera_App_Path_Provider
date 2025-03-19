import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cameramain1/gallery.dart';

import 'package:cameramain1/main.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

class TakingPhot extends StatefulWidget {
  const TakingPhot({
    super.key,
  });

  @override
  State<TakingPhot> createState() => _TakingPhotState();
}

class _TakingPhotState extends State<TakingPhot> {
  ValueNotifier<List<File>> images = ValueNotifier([]);
  late CameraController controllerCamera;
  bool isinitialized = false;
  File? latestimage;
  int camera=0;
  // bool checkrear=false;
  // List<File> images=[];

  @override
  void initState() {
    initializeCamera();
    
    loadImage();
    super.initState();
  }

  Future<void> initializeCamera() async {
    if (availableCamera.isNotEmpty) {
      controllerCamera =
          CameraController(availableCamera[camera], ResolutionPreset.veryHigh);
      try {
        await controllerCamera.initialize();
        setState(() {
          isinitialized = true;
        });
      } catch(e){
        print("error $e");
      }
    } else {
      print("error while initializing");
    }
  }

  @override
  void dispose() {
    controllerCamera.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          height: 100,
          child: isinitialized == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // IconButton(
                    //     onPressed: () {
                    //       Navigator.push(context, MaterialPageRoute(builder: (context) => Gallery(images: images),));
                    //     },
                    //     icon: const Icon(
                    //       Icons.photo_camera_back_outlined,
                    //       size: 70,
                    //       color: Colors.blueAccent,
                    //     )),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Gallery(images: images),
                            ));
                      },
                      child: CircleAvatar(backgroundColor: Colors.grey.shade800,
                        backgroundImage: latestimage == null
                            ? null
                            : FileImage(latestimage!),
                        radius: 30,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          try {
                            // final img =
                            //     await controllerCamera.takePicture();

                            // await Gal.putImage(img.path);

                            takeAndSave();
                          } catch (e) {
                            print("error$e");
                          }
                        },
                        icon: const Icon(
                          Icons.camera,
                          size: 80,
                          color: Colors.white,
                        )),
                        
                        IconButton(onPressed: ()async{
                          setState(() {
                            camera= (camera==0)?1:0;
                          });
                          await initializeCamera();
                        }, icon:const Icon(Icons.cameraswitch_sharp,color: Colors.white,size: 50,))
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
        body: isinitialized == true
            ? SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: CameraPreview(
                  controllerCamera,
                  child: Stack(children: [IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon:const Icon(Icons.arrow_back,size: 40,))],)
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  //dirctoryoppening

  Future<Directory> createDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagepath = Directory("${directory.path}/capturedimage");

    if (!await imagepath.exists()) {
      await imagepath.create(recursive: true);
    }
    return imagepath;
  }

  //image save and takepick

  Future<void> takeAndSave() async {
    if (!controllerCamera.value.isInitialized) return;

    try {
      final directory = await createDirectory();
      final path =
          "${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
      final XFile imagetaken = await controllerCamera.takePicture();

      //savingimage
      final savedimg = await File(imagetaken.path).copy(path);
      setState(() {
        latestimage = savedimg;
      });

      images.value.insert(0, savedimg);
    } catch (e) {
      print("error while takingpicture$e");
    }
  }

  Future<void> loadImage() async {
    final directory = await createDirectory();
    final file = directory.listSync().whereType<File>().toList().reversed;
    images.value = file.toList();
  }
}
