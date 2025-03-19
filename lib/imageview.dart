import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class Imageview extends StatelessWidget {
  final ValueNotifier<List<File>> images;
  int index;
  
  Imageview({super.key,required this.images,required this.index});
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          // bottom: AppBar(),
          title: const Text(
            "Image",
          ),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        body: Image.file(images.value[index]),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black87,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () async {
                    File fileimage = images.value[index];
                    XFile xfile=XFile(fileimage.path);
                    await Share.shareXFiles([xfile], text: "$fileimage");
                  },
                  icon: const Icon(
                    Icons.share,
                    color:Colors.blue,
                    size:30,
                  )),
              IconButton(
                  onPressed:()async{

                    await images.value[index].delete();//file
                    images.value.removeAt(index);//list
                    
                    images.notifyListeners();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {
                    final img = images.value[index];
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(img.path)));
                  },
                  icon: const Icon(
                    Icons.info,
                    color: Colors.blue,
                    size: 30,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
