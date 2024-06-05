import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());



class DraggableObj extends StatefulWidget {
  const DraggableObj({super.key});

  @override
  State<DraggableObj> createState() => _DraggableObjState();
}

class _DraggableObjState extends State<DraggableObj> {
  int value = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Draggable<int>(
          data: 10,
          feedback: Container(
            height: 200,
            width: 200,
            color:Colors.red,
            child: const Icon(Icons.directions_run),
          ),
          childWhenDragging: Container(
            height: 100,
            width: 100.0,
            color: Colors.pinkAccent,
          ),

          child: Container(
            height: 200,
            width: 200,
            color: Colors.blueAccent,
            child: const Text("The Draggable object!"),
          ),
        ),
        DragTarget<int>(
          builder: (BuildContext context,List<dynamic> accepted,List<dynamic> rejected){
            return Container(
              height: 200,
              width: 200,
              color:Colors.lightGreenAccent,
              child: Text("Draggable Object with value : $value"),
            );
          },
          onAcceptWithDetails: (DragTargetDetails<int> details){
            setState(() {
              value += details.data;
            });
          },
        )
      ],
    ) ;
  }
}

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({super.key});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final myController = TextEditingController();
  String inputText = "";
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Container(
          width: 200,
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal:10),
          child: TextFormField(
            controller: myController,

            onChanged: (value){
              setState(() {
                inputText = value;
              });
            },
            decoration: InputDecoration(
                border:const OutlineInputBorder(),
                labelText: "Name",
                labelStyle:GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )
                )
            ),
          ),
        ),
        Text("value : $inputText")
      ],
    );
  }
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var some = 0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(200, 0, 20, 0.2)
      ),

      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body:const Center(child: TextFieldWidget()),
      ),

    );
  }
}


