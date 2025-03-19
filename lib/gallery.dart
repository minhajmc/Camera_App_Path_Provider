import 'dart:io';

import 'package:cameramain1/imageview.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  ValueNotifier<List<File>> images = ValueNotifier([]);

  Gallery({super.key, required this.images});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

 int indexscreen=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          title: const Text(
            " Gallery",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.shade200,
          iconTheme: const IconThemeData(size: 30),
          // actions: [
          //   IconButton(
          //       onPressed: () async {
          //         images.value.clear();

          //         images.notifyListeners();
          //           ifalldelete=true;

          //       },
          //       icon: const Icon(Icons.delete)),
          // ],
        ),
        body: widget.images.value.isNotEmpty
            ? ValueListenableBuilder(
                valueListenable: widget.images,
                builder: (context, value, child) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: value.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 6,
                            crossAxisSpacing: 6),
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Imageview(
                                    images: widget.images,
                                    index: index,
                                  ),
                                ));
                          },
                          child: Card(
                            elevation: 8,
                            child: Image.file(
                              value[index],
                              fit: BoxFit.cover,
                            ),
                          ));
                    },
                  );
                },
              )
            : const Center(
                child: Text("No image yet"),
              ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if(index==1){
              Navigator.pop(context);
            }
            
            indexscreen=index;
            setState(() {
              
            });
            
          },
            backgroundColor: Colors.blue.shade100,
            currentIndex: indexscreen,
            fixedColor: Colors.amber,
            items: const [
               BottomNavigationBarItem(
                  label: "Gallery",
                  icon: Icon(Icons.photo,size: 30,color: Colors.black,),),
              BottomNavigationBarItem(
                  label: "Camera",
                  icon: Icon( Icons.camera_alt,
                        size: 30,
                        color: Colors.black)),
            ]),
      ),
    );
  }
}
